import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class SingleOrderDetailsUI extends GetView<OrderController> {
  const SingleOrderDetailsUI(
      {Key? key, this.orderModel, this.calledForBuyerOrderDetails})
      : super(key: key);
  final OrderModel? orderModel;

  final bool? calledForBuyerOrderDetails;

  @override
  Widget build(BuildContext context) {
    //if (Get.parameters['id'] == null ||Get.arguments==null || Get.arguments['calledForBuyerOrderDetails'] == null) {
    if (orderModel?.id == null) {
      //return noDataFound();
      return CustomLoading();
    }
    //if (Get.arguments['calledForBuyerOrderDetails']) {
    if (calledForBuyerOrderDetails!) {
      //controller.fetchOrderById(int.parse(Get.parameters['id']!));
      controller.fetchOrderById(orderModel!.id!);
    } else {
      //controller.fetchVendorOrderById(int.parse(Get.parameters['id']!));
      controller.fetchVendorOrderById(orderModel!.id!);
    }

    return Obx(() => controller.orderDetailsModel?.id == null
        ? noDataFound()
        : _build(model: controller.orderDetailsModel));

    /* return controller.obx((state) {
      if (state == null) {
        return CustomLoading();
      }
      return _build(orderModel: state);
    }, onLoading: CustomLoading());*/
  }

  Widget noDataFound() {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.grey[100]!,
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: kPrimaryColor,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(title: "Order Details", style: appBarTitleSize),
              buildSvgLogo(),
            ],
          ),
        ),
        body: Center(
          child: NoDataFoundWithIcon(
            icon: IconlyLight.buy,
            title: langKey.noDataFound.tr,
          ),
        ),
      ),
    );
  }

  Widget _build({OrderModel? model}) {
    return Scaffold(
      //backgroundColor: Colors.grey[300]!,
      body: CustomScrollView(
        slivers: [
          _sliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      AppConstant.spaceWidget(height: 20),
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: "INVOICE NO: ${model?.id ?? 0}",
                              style: headline3,
                            ),
                            CustomText(
                                title:
                                    "Date: ${AppConstant.formattedDataTime("MMMM dd, yyyy", model!.createdAt ?? DateTime.now())}"),
                          ],
                        ),
                        trailing: CustomText(
                          title: model.status?.capitalizeFirst,
                          color: AppConstant.getStatusColor(model),
                          weight: FontWeight.w600,
                        ),
                      ),

                      ///Invoice TO:
                      ListTile(
                        title: CustomText(
                          title: "Billing Details:",
                          style: appBarTitleSize,
                        ),
                        subtitle: CustomText(
                          title: getAddress(model: model.billingDetail),
                          style: bodyText2,
                          maxLines: 5,
                        ),
                      ),

                      AppConstant.spaceWidget(height: 20),
                      _invoiceBody(model: model),

                      AppConstant.spaceWidget(height: 10),
                      _invoiceFooter(orderModel: model),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      backgroundColor: kAppBarColor,
      automaticallyImplyLeading: true,
      leadingWidth: 30,
      floating: true,
      pinned: true,
      //centerTitle: true,
      leading: InkWell(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kPrimaryColor,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(title: "Order Details", style: appBarTitleSize),
          buildSvgLogo(),
        ],
      ),
    );
  }

  String getAddress({UserModel? model}) {
    return "${model?.name ?? null}\n ${model?.phone ?? null}\n ${model?.address ?? ""}, ${model?.zipCode ?? null}\n ${model?.city?.name ?? null}, ${model?.country?.name ?? null}";
  }

  Widget _invoiceBody({OrderModel? model}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
            child: Row(
              children: [
                Expanded(flex: 2, child: _dataHeader(text: "Product Name")),
                Expanded(child: _dataHeader(text: "Qty")),
                Expanded(child: _dataHeader(text: "Price")),
                Expanded(child: _dataHeader(text: "Amount")),
                Expanded(child: _dataHeader(text: "Action")),
              ],
            ),
          ),
          Column(
            children: model!.orderItems!.isEmpty
                ? [NoDataFound()]
                : model.orderItems!.map((OrderItem orderItem) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: _boxDecoration(
                          lastIndex: model.orderItems!.indexOf(orderItem) + 1,
                          length: model.orderItems!.length),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: _dataCell(
                                  text: '${orderItem.product?.name}')),
                          Expanded(
                              child: _dataCell(text: '${orderItem.quantity}')),
                          Expanded(
                              child: _dataCell(
                                  text: '${orderItem.product?.discountPrice}')),
                          Expanded(
                              child: _dataCell(text: '${orderItem.price}')),
                          Expanded(
                              child: model.status!.contains("pending")
                                  ? Container()
                                  : _dataAction(orderItemModel: orderItem)),
                        ],
                      ),
                    );
                  }).toList(),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration({int? lastIndex, length}) {
    final borderSide = BorderSide(color: kPrimaryColor);
    if (lastIndex!.isEqual(length))
      return BoxDecoration(
        border: Border.all(color: kPrimaryColor),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
      );

    return BoxDecoration(
      border: Border(
        left: borderSide,
        right: borderSide,
        top: borderSide,
      ),
    );
  }

  _dataHeader({text}) {
    return CustomText(
      title: text,
      style:
          bodyText1.copyWith(fontWeight: FontWeight.bold, color: kWhiteColor),
    );
  }

  _dataCell({text}) {
    return CustomText(
      title: text,
      style: bodyText2Poppins,
    );
  }

  _dataAction({OrderItem? orderItemModel}) {
    return Row(
      children: [
        CustomActionIcon(
          onTap: () {},
          icon: Icons.feedback_outlined,
          iconColor: kPrimaryColor,
        ),
        CustomActionIcon(
          onTap: () {
            AppConstant.showBottomSheet(
                isGetXBottomSheet: true,
                buildContext: Get.context,
                widget: addDisputeItems(orderItem: orderItemModel));
          },
          icon: Icons.cases_outlined,
          iconColor: kRedColor,
        ),
      ],
    );
  }

  Widget _invoiceFooter({OrderModel? orderModel}) {
    return Column(
      children: [
        Row(
          children: [
            _textWidget(
                title: "Payment Method",
                value: orderModel?.paymentMethod ?? ""),
            _textWidget(
                title: "Delivery Date",
                value: AppConstant.formattedDataTime(
                    "MMMM dd, yyyy", orderModel!.expectedDeliveryDate!)),
          ],
        ),
        Row(
          children: [
            _textWidget(
                title: "Shipping Cost", value: orderModel?.shippingPrice ?? 0),
            _textWidget(
                title: "Total Price",
                value: orderModel.totalPrice ?? 0,
                valueColor: kRedColor),
          ],
        ),
      ],
    );
  }

  _textWidget({title, value, valueColor}) {
    return Expanded(
      child: Card(
        child: ListTile(
          title: CustomText(
            title: title,
            color: kDarkColor,
          ),
          subtitle: CustomText(
            title: "${value}",
            style: headline2.copyWith(color: valueColor ?? kPrimaryColor),
          ),
        ),
      ),
    );
  }

  Widget addDisputeItems({OrderItem? orderItem}) {
    var formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StickyLabel(
                  text: "Dispute",
                  style: headline1,
                ),
              ],
            ),
            AppConstant.spaceWidget(height: 5),
            CustomText(
              title:
                  "Claims can be made only in the event of the loss or damage of a parcel",
              style: headline3.copyWith(color: kLightColor),
            ),
            AppConstant.spaceWidget(height: 15),
            GestureDetector(
              onTap: () => controller.pickMultipleImages(),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                dashPattern: const [10, 4],
                strokeCap: StrokeCap.round,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(
                    () => controller.pickedImagesList.isNotEmpty
                        ? ShowPickedImagesList(
                            pickedImagesList: controller.pickedImagesList)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.attach_file_outlined,
                                size: 30,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Click here to upload',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
            AppConstant.spaceWidget(height: 15),
            FormInputFieldWithIcon(
              controller: controller.titleController,
              iconPrefix: Icons.title,
              labelText: title.tr,
              iconColor: kPrimaryColor,
              autofocus: false,
              textStyle: bodyText1,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  GetUtils.isBlank(value!)! ? titleReq.tr : null,
              keyboardType: TextInputType.name,
              onChanged: (value) {},
              onSaved: (value) {},
            ),
            AppConstant.spaceWidget(height: 10),
            FormInputFieldWithIcon(
              controller: controller.descriptionController,
              iconPrefix: Icons.description,
              labelText: description.tr,
              iconColor: kPrimaryColor,
              autofocus: false,
              textStyle: bodyText1,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  GetUtils.isBlank(value!)! ? descriptionReq.tr : null,
              keyboardType: TextInputType.name,
              onChanged: (value) {},
              onSaved: (value) {},
            ),
            AppConstant.spaceWidget(height: 20),
            Obx(
              () => controller.isLoading.isTrue
                  ? CustomLoading(isItBtn: true)
                  : CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await controller.disputeOnOrders(
                              orderId: orderItem?.id!);
                        }
                      },
                      text: submit.tr,
                      height: 40,
                      width: 200,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
