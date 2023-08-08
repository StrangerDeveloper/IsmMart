import 'package:get/get.dart';
import '../../../api_helper/local_storage/local_storage_helper.dart';
import '../../../controllers/buyer/auth/auth_controller.dart';
import '../../../helper/api_base_helper.dart';
import '../../../helper/global_variables.dart';
import '../../../models/user/user_model.dart';
import '../../setting/settings_viewmodel.dart';

class VendorSignUp4ViewModel extends GetxController {

  RxBool fromSettings = false.obs;

  @override
  void onInit()async {
    fromSettings.value = Get.arguments['fromSettings'];
    await getCurrentUser();
    super.onInit();
  }

  Future<void> getCurrentUser() async {
    await ApiBaseHelper()
        .getMethod(url: 'user/profile', withAuthorization: true)
        .then((parsedJson) async {
      if (parsedJson['success'] is bool == true) {
        UserResponse userResponse = UserResponse.fromResponse(parsedJson);
        userResponse.userModel!.token = parsedJson['data']['token'];
        GlobalVariable.userModel = userResponse.userModel;
        SettingViewModel settingViewModel = Get.find();
        settingViewModel.setUserModel(userResponse.userModel);
        AuthController authController = Get.find();
        authController.setCurrUserToken(parsedJson['data']['token']);
        await LocalStorageHelper.storeUser(userModel: userResponse.userModel)
            .then((value) {});
      }
    });
  }
}