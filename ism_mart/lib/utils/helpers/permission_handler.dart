import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionsHandler {
  //PermissionsHandler._();

  Future<bool> checkPermissions() async {
    return true;

    /*if (Platform.isIOS)
      return true;
      return await Permission.photos.isGranted &&
          //await Permission.mediaLibrary.isGranted &&
          await Permission.camera.isGranted;

    return //await Permission.manageExternalStorage.isGranted &&
        await Permission.storage.isGranted &&
            //await Permission.photos.isGranted &&
            await Permission.camera.isGranted;*/
  }

  requestPermissions() {
    if (Platform.isAndroid) {
      _requestAndroidPhotoPermissions();
    } else
      _requestIOSPhotoPermissions();
  }

  _requestAndroidPhotoPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      //Permission.manageExternalStorage,
      Permission.camera,
      //Permission.photos,
      Permission.storage,
      //Permission.mediaLibrary,
      //add more permission to request here.
    ].request();
    if (//statuses[Permission.manageExternalStorage]!.isDenied &&
        statuses[Permission.camera]!.isDenied &&
        //statuses[Permission.photos]!.isDenied &&
        statuses[Permission.storage]!.isDenied) {
      //check each permission status after.
      print(">>>>permission is denied.");
    }
  }

  _requestIOSPhotoPermissions() async {
    if (await Permission.camera.request().isGranted ||
        await Permission.photos.request().isGranted ||
        await Permission.mediaLibrary.request().isGranted) {
      //check each permission status after.
      print(">>>>permission is granted. ");
    }
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.photos,
      Permission.mediaLibrary,
      //add more permission to request here.
    ].request();
    if ( //statuses[Permission.mediaLibrary]!.isDenied &&
        statuses[Permission.camera]!.isDenied &&
            statuses[Permission.photos]!.isDenied) {
      //check each permission status after.
      print(">>>>permission is denied.");
    }if ( //statuses[Permission.mediaLibrary]!.isDenied &&
        statuses[Permission.camera]!.isRestricted &&
            statuses[Permission.photos]!.isRestricted) {
      //check each permission status after.
      print(">>>>permission is Restricted.");
    }if ( //statuses[Permission.mediaLibrary]!.isDenied &&
        statuses[Permission.camera]!.isPermanentlyDenied &&
            statuses[Permission.photos]!.isPermanentlyDenied) {
      //check each permission status after.
      print(">>>>permission is P denied.");
      await Permission.camera.request();
      await Permission.photos.request();
    }
  }
}
