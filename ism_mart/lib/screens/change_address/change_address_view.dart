import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/screens/change_address/change_address_viewmodel.dart';
import 'package:ism_mart/widgets/custom_appbar.dart';
import '../../utils/exports_utils.dart';
import '../../widgets/export_widgets.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import '../../widgets/loader_view.dart';

class ChangeAddressView extends StatelessWidget {
  ChangeAddressView({super.key});

  final ChangeAddressViewModel viewModel = Get.put(ChangeAddressViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: langKey.shippingAddressDetail.tr,
        ),
        // appBar(),
        body: Stack(
          children: [
            Column(
              children: [
                addNewAddress(),
                listView(),
              ],
            ),
            LoaderView(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: kAppBarColor,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kPrimaryColor,
        ),
      ),
      title: CustomText(
        title: langKey.shippingAddressDetail.tr,
        style: appBarTitleSize,
      ),
    );
  }

  Widget addNewAddress() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StickyLabel(text: langKey.shippingDetails.tr),
          CustomTextBtn(
            width: 120,
            height: 30,
            onPressed: () {
              if (viewModel.shippingAddressList.length >= 3) {
                AppConstant.displaySnackBar(
                  'error',
                  langKey.maxAddressLimitMsg.tr,
                );
                return;
              }
              Get.toNamed(Routes.addUpdateAddress,
                  arguments: {'isUpdateScreen': false});
            },
            title: langKey.addNew.tr,
          ),
        ],
      ),
    );
  }

  Widget listView() {
    return Obx(
      () => viewModel.shippingAddressList.isEmpty
          ? _buildNewAddress()
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: viewModel.shippingAddressList.length,
              itemBuilder: (BuildContext, index) {
                return listViewItem(index);
              },
            ),
    );
  }

  Widget listViewItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Stack(
        children: [
          CustomGreyBorderContainer(
            isSelected: viewModel.shippingAddressList[index].defaultAddress!,
            activeColor: kPrimaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: ListTile(
              onTap: () {
                viewModel.changeDefaultShippingAddress(
                    viewModel.shippingAddressList[index].id.toString());
              },
              title: CustomText(
                title: viewModel.shippingAddressList[index].name,
                style: headline3,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: viewModel.shippingAddressList[index].phone ?? '',
                    style: bodyText1,
                  ),
                  CustomText(
                    style: bodyText1,
                    title: "${viewModel.shippingAddressList[index].address!}, "
                        "${viewModel.shippingAddressList[index].zipCode!}, "
                        "${viewModel.shippingAddressList[index].city!.name!},"
                        " ${viewModel.shippingAddressList[index].country!.name!}",
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Row(
              children: [
                CustomActionIcon(
                  onTap: () {
                    Get.toNamed(Routes.addUpdateAddress, arguments: {
                      'isUpdateScreen': true,
                      'model': viewModel.shippingAddressList[index]
                    });
                  },
                  size: 15,
                  height: 25,
                  width: 25,
                  icon: Icons.edit_rounded,
                  bgColor: kPrimaryColor,
                ),
                AppConstant.spaceWidget(width: 5),
                CustomActionIcon(
                  onTap: () {
                    viewModel.deleteShippingDetails(
                        viewModel.shippingAddressList[index].id);
                  },
                  size: 15,
                  height: 25,
                  width: 25,
                  icon: Icons.delete_rounded,
                  bgColor: kRedColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewAddress() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: AppResponsiveness.height * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NoDataFoundWithIcon(
              title: langKey.noDefaultAddressFound.tr,
              icon: Icons.location_city_rounded,
            ),
            AppConstant.spaceWidget(height: 10),
            CustomTextBtn(
              width: 150,
              height: 40,
              onPressed: () {
                // Get.back();
                // AppConstant.showBottomSheet(
                //     widget: addNewORUpdateAddressContents());
              },
              title: langKey.addNewAddress.tr,
            ),
          ],
        ),
      ),
    );
  }
}
