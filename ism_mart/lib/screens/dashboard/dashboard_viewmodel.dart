import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class DashboardViewModel extends GetxController {
  RxString currentAddress = ''.obs;
  Position? currentPosition;

  Future<void> getCurrentLocation()async{
    GlobalVariable.showLoader.value = true;
    final hasPermissions = await handleLocationPermission();
    if(!hasPermissions){
      GlobalVariable.showLoader.value = false;
      return;
    } else{
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
          currentPosition = position;
        getAddressFromPosition(currentPosition!);
      }).catchError((e){
        GlobalVariable.showLoader.value = false;
        AppConstant.displaySnackBar(langKey.errorTitle.tr, e);
      });
    }
  }

  Future<bool> handleLocationPermission()async {
    bool serviceEnabled = false;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AppConstant.displaySnackBar(langKey.errorTitle.tr, 'Enable location');
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        AppConstant.displaySnackBar(
            langKey.errorTitle.tr, 'Location access denied');
        return false;
      }
    } else if (permission == LocationPermission.deniedForever) {
      AppConstant.displaySnackBar(
          langKey.errorTitle.tr, 'Location access permanently denied');
      return false;
    }
    return true;
  }

  getAddressFromPosition(Position position) async{
    await placemarkFromCoordinates(currentPosition!.latitude, currentPosition!.longitude).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress.value = "${place.locality}, " + "${place.country}";
      GlobalVariable.showLoader.value = false;
      if(currentAddress.value.isNotEmpty) {
        Get.toNamed(Routes.chatScreen, arguments: {"location": currentAddress.value});
      } else{
        AppConstant.displaySnackBar(langKey.errorTitle.tr, 'Encountered error while trying to fetch location. Try Again');
      }
    }).catchError((e) {
      AppConstant.displaySnackBar(langKey.errorTitle.tr, e);
      GlobalVariable.showLoader.value = false;
    });
  }

}