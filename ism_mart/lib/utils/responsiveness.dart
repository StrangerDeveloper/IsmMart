import 'package:ism_mart/utils/exports_utils.dart';

class AppResponsiveness {
  AppResponsiveness._();

  //var width = AppConstant.getSize().width;
  static final height = AppConstant.getSize().height;

  static bool _isLargeScreen() {
    return AppConstant.getSize().height > 800;
  }

  ///text Size
  static double getTextSize13() {
    return _isLargeScreen() ? 16.0 : 13.0;
  }

  /// box/section size

  static double getBoxHeightPoint15() {
    return height * (_isLargeScreen() ? 0.2 : 0.15);
  }


}
