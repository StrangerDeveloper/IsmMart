import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/presentation/ui/buyer/dispute_detail/dispute_detail_view.dart';
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
      return CustomLoading();
    }
    if (calledForBuyerOrderDetails!) {
      controller.fetchOrderById(orderModel!.id!);
    } else {
      controller.fetchVendorOrderById(orderModel!.id!);
    }

    return Obx(() => controller.orderDetailsModel?.id == null
        ? noDataFound()
        : _build(model: controller.orderDetailsModel));
  }

  Widget noDataFound() {
    return SafeArea(
      child: Scaffold(
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
              CustomText(title: langKey.orderDetail.tr, style: appBarTitleSize),
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
                              title: "${langKey.invoiceNo}: ${model?.id ?? 0}",
                              style: headline3,
                            ),
                            CustomText(
                              title:
                                  "${langKey.Date.tr}: ${AppConstant.formattedDataTime("MMMM dd, yyyy", model!.createdAt ?? DateTime.now())}",
                            ),
                          ],
                        ),
                        trailing: CustomText(
                          title: model.status?.capitalizeFirst,
                          color: AppConstant.getStatusColor(model),
                          weight: FontWeight.w600,
                        ),
                      ),

                      ///Invoice TO:
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomGreyBorderContainer(
                          hasShadow: false,
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            title: CustomText(
                              title: "${langKey.billingDetails.tr}:",
                              style: appBarTitleSize,
                            ),
                            subtitle: CustomText(
                              title: getAddress(model: model.billingDetail),
                              style: bodyText2.copyWith(color: kLightColor),
                              maxLines: 5,
                            ),
                          ),
                        ),
                      ),

                      ///Invoice From:
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomGreyBorderContainer(
                          hasShadow: false,
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            title: CustomText(
                              title: "${langKey.vendorStoreDetails.tr}:",
                              style: appBarTitleSize,
                            ),
                            subtitle: CustomText(
                              title:
                                  getVendorDetails(vendor: model.vendorDetails),
                              style: bodyText2.copyWith(color: kLightColor),
                              maxLines: 5,
                            ),
                          ),
                        ),
                      ),

                      AppConstant.spaceWidget(height: 20),
                      _invoiceBody(model: model),
                      // CustomTextBtn(
                      //   width: 150,
                      //   onPressed: () {
                      //     Get.to(() => AllDisputeView());
                      //   },
                      //   child: Text('View All Disputes'),
                      // ),
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
          CustomText(
              title: "${langKey.orderDetail.tr}", style: appBarTitleSize),
          buildSvgLogo(),
        ],
      ),
    );
  }

  String getAddress({UserModel? model}) {
    return "${model?.name ?? null}\n ${model?.phone ?? null}\n ${model?.address ?? ""}, ${model?.zipCode ?? null}\n ${model?.city?.name ?? null}, ${model?.country?.name ?? null}";
  }

  String getVendorDetails({UserModel? vendor}) {
    return "${vendor?.vendor!.storeName ?? vendor?.firstName ?? null}\n ${vendor!.vendor?.phone ?? null}";
  }

  Widget _invoiceBody({OrderModel? model}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
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
                Expanded(
                    flex: 2, child: _dataHeader(text: langKey.productName.tr)),
                Expanded(
                    child: Align(
                  alignment: Alignment.center,
                  child: _dataHeader(text: langKey.qty.tr),
                )),
                Expanded(child: _dataHeader(text: langKey.price.tr)),
                Expanded(child: _dataHeader(text: langKey.amount.tr)),
                Expanded(
                    child: Align(
                        alignment: Alignment.center,
                        child: _dataHeader(text: langKey.action.tr))),
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
                        length: model.orderItems!.length,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _dataCell(text: '${orderItem.product?.name}'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: _dataCell(text: '${orderItem.quantity}'),
                            ),
                          ),
                          Expanded(
                            child: CustomPriceWidget(
                              title: "${orderItem.product?.discountPrice}",
                              style: bodyText2Poppins,
                            ),
                            /*_dataCell(
                                  text: orderItem.product?.discountPrice)*/
                          ),
                          Expanded(
                            child: CustomPriceWidget(
                                title: "${orderItem.price}",
                                style:
                                    bodyText2Poppins) /*_dataCell(text: '${orderItem.price}')*/,
                          ),
                          Expanded(
                            child: model.status!.contains("pending")
                                ? Container()
                                : _dataAction(orderItemModel: orderItem),
                          ),
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
        Expanded(
          child: CustomActionIcon(
            onTap: () {
              addReviewBottomSheet(orderItem: orderItemModel);
            },
            icon: Icons.feedback_outlined,
            iconColor: kPrimaryColor,
          ),
        ),
        Expanded(
          child: CustomActionIcon(
            onTap: () {
              disputeActionsBottomSheet(orderItem: orderItemModel);
            },
            icon: Icons.cases_outlined,
            iconColor: kRedColor,
          ),
        ),
      ],
    );
  }

  addReviewBottomSheet({OrderItem? orderItem}) {
    controller.rating.value = 0;
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      context: Get.context!,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Form(
                key: controller.reviewFormKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StickyLabel(
                            text: langKey.reviews.tr,
                            style: headline1,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: RichText(
                          text: TextSpan(
                            text: langKey.rating.tr,
                            style: const TextStyle(
                              //fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              const TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      RatingBar.builder(
                        onRatingUpdate: (rating) {
                          controller.rating.value = rating;
                        },
                        initialRating: controller.rating.value,
                        glowColor: Color(0xFFFFCC80),
                        direction: Axis.horizontal,
                        unratedColor: Color(0xffC4C4C4),
                        itemCount: 5,
                        itemSize: 25,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Color(0xFFFFA726),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: CustomTextField1(
                          controller: controller.reviewTxtFieldController,
                          title: langKey.reviews.tr,
                          asterisk: true,
                          minLines: 4,
                          maxLines: 6,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return CommonFunctions.validateDefaultTxtField(
                                value);
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Obx(
                          () => controller.isLoading.isTrue
                              ? CustomLoading(isItBtn: true)
                              : CustomButton(
                                  onTap: () async {
                                    await controller.submitReviewBtn(
                                        orderItem: orderItem);
                                  },
                                  text: submit.tr,
                                  height: 40,
                                  width: 200,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.close),
              )
            ],
          ),
        );
      },
    );
  }

  disputeActionsBottomSheet({OrderItem? orderItem}) {
    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      langKey.disputes.tr,
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              Divider(),
              BottomSheetItemRow(
                title: langKey.addDisputes.tr,
                icon: CupertinoIcons.add,
                isDisabled:
                    (orderItem?.tickets?.isEmpty ?? false) ? false : true,
                onTap: () {
                  Navigator.of(context).pop();
                  AppConstant.showBottomSheet(
                    isGetXBottomSheet: true,
                    buildContext: Get.context,
                    widget: addDisputeItems(orderItem: orderItem),
                  );
                },
              ),
              BottomSheetItemRow(
                title: langKey.viewDispute.tr,
                icon: IconlyLight.document,
                isDisabled:
                    (orderItem?.tickets?.isNotEmpty ?? false) ? false : true,
                onTap: () {
                  Navigator.of(context).pop();
                  Get.to(() => DisputeDetailView(),
                      arguments: {'id': orderItem!.tickets![0].id.toString()});
                },
              ),
              BottomSheetItemRow(
                title: langKey.deleteDisputes.tr,
                icon: IconlyLight.delete,
                isDisabled:
                    (orderItem?.tickets?.isNotEmpty ?? false) ? false : true,
                onTap: () {
                  Navigator.of(context).pop();
                  showDeleteDisputeDialog(context, orderItem);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future showDeleteDisputeDialog(
      BuildContext context, OrderItem? orderItem) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(langKey.deleteDisputes.tr),
          content: Text(langKey.deleteDisputesMsg.tr),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.infinity, 40),
                      foregroundColor: Colors.grey,
                    ),
                    child: Text(
                      langKey.noBtn.tr,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(Get.context!).pop();
                    },
                  ),
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.infinity, 40),
                      foregroundColor: Colors.grey,
                    ),
                    child: Text(
                      langKey.yesBtn.tr,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      controller.deleteTicket(
                        orderItem!.tickets![0].id.toString(),
                        orderModel!.id.toString(),
                      );
                      Navigator.of(Get.context!).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _invoiceFooter({OrderModel? orderModel}) {
    return Column(
      children: [
        Row(
          children: [
            _textWidget(
              title: langKey.paymentMethod.tr,
              value: orderModel?.paymentMethod ?? "",
            ),
            _textWidget(
              title: langKey.deliveryDate.tr,
              value: AppConstant.formattedDataTime(
                "MMMM dd, yyyy",
                orderModel!.expectedDeliveryDate!,
              ),
            ),
          ],
        ),
        Row(
          children: [
            _textWidget(
              title: langKey.shippingCost.tr,
              value: orderModel.shippingPrice ?? 0,
              valueIsPrice: true,
            ),
            _textWidget(
                title: langKey.totalPrice.tr,
                value: orderModel.totalPrice ?? 0,
                valueIsPrice: true,
                valueColor: kRedColor),
          ],
        ),
      ],
    );
  }

  _textWidget({title, value, valueColor, bool? valueIsPrice = false}) {
    return Expanded(
      child: Card(
        child: ListTile(
          title: CustomText(
            title: title,
            color: kDarkColor,
          ),
          subtitle: valueIsPrice!
              ? CustomPriceWidget(
                  title: "${value}",
                  style: headline2.copyWith(color: valueColor ?? kPrimaryColor),
                )
              : CustomText(
                  title: "${value}",
                  style: headline2.copyWith(color: valueColor ?? kPrimaryColor),
                ),
        ),
      ),
    );
  }

  Widget addDisputeItems({OrderItem? orderItem, bool isUpdate = false}) {
    var formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StickyLabel(
                    text: langKey.disputes.tr,
                    style: headline1,
                  ),
                ],
              ),
              AppConstant.spaceWidget(height: 5),
              CustomText(
                title: langKey.claimCanBeMade.tr,
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
                                  langKey.clickHereToUpload.tr,
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
                labelText: titleKey.tr,
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
                                orderItem: orderItem, orderId: orderModel!.id!);
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
      ),
    );
  }
}

class BottomSheetItemRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final GestureTapCallback? onTap;
  final bool isDisabled;

  const BottomSheetItemRow({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
    required this.isDisabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: isDisabled ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 0.5,
                  color: isDisabled ? Colors.grey : Colors.black,
                ),
              ),
              child: Icon(
                icon,
                size: 20,
                color: isDisabled ? Colors.grey : Colors.black,
              ),
            ),
            SizedBox(width: 13),
            Text(
              title,
              style: GoogleFonts.lato(
                fontSize: 15,
                color: isDisabled ? Colors.grey : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
