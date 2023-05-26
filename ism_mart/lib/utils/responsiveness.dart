import 'package:ism_mart/utils/exports_utils.dart';

class AppResponsiveness {
  AppResponsiveness._();

  //var width = AppConstant.getSize().width;
  static final height = AppConstant.getSize().height;
  static final width = AppConstant.getSize().width;

  static bool _isTabletScreen() {
    return AppConstant.getSize().width >= 850 &&
        AppConstant.getSize().width < 1100;
  }

  ///text Size
  static double getTextSize13_16() {
    return _isTabletScreen() ? 16.0 : 13.0;
  }

  // width

  static double getWidthPoint90() {
    return width * 0.9;
  }

  // container heights
  static double getHeight50_60() {
    return _isTabletScreen() ? 60 : 50;
  }

  static double getHeight60_70() {
    return _isTabletScreen() ? 70 : 60;
  }

  static double getHeight70_80() {
    return _isTabletScreen() ? 80 : 70;
  }

  static double getHeight80_90() {
    return _isTabletScreen() ? 90 : 80;
  }

  static double getHeight90_100() {
    return _isTabletScreen() ? 100 : 90;
  }

  static double getHeight50_100() {
    return _isTabletScreen() ? 100 : 50;
  }

  static double getHeight90_140() {
    return _isTabletScreen() ? 140 : 90;
  }

  static double getHeight100_120() {
    return _isTabletScreen() ? 120 : 100;
  }

  static double getHeight100_150() {
    return _isTabletScreen() ? 150 : 100;
  }

  //container widths
  static double getWidth50() {
    return _isTabletScreen() ? 60 : 50;
  }

  /// box/section size based on small screen
  ///
  static double getBoxHeightPoint5() {
    return height * (_isTabletScreen() ? 0.08 : 0.12);
  }

  static double getBoxHeightPoint15() {
    return height * (_isTabletScreen() ? 0.2 : 0.15);
  }

  static double getBoxHeightPoint21() {
    return height * (_isTabletScreen() ? 0.24 : 0.21);
  }

  static double getBoxHeightPoint25() {
    return height * (_isTabletScreen() ? 0.2 : 0.25);
  }

  static double getBoxHeightPoint28() {
    return height * (_isTabletScreen() ? 0.25 : 0.28);
  }

  static double getBoxHeightPoint30() {
    return height * (_isTabletScreen() ? 0.27 : 0.30);
  }

  static double getBoxHeightPoint32() {
    return height * (_isTabletScreen() ? 0.29 : 0.32);
  }

  static double getBoxHeightPoint35() {
    return height * (_isTabletScreen() ? 0.40 : 0.35);
  }

  static double getBoxHeightPoint60() {
    return height * (_isTabletScreen() ? 0.65 : 0.6);
  }

  ///Gridview contents

  static int getGridItemCount() {
    return _isTabletScreen() ? 3 : 2;
  }

  /// Gridview mainAxisExtent
  // static double getMainAxisExtentPoint25() {
  //   return height * (_isTabletScreen() ? 0.30 : 0.25);
  // }

  static double getChildAspectRatioPoint60() {
    return _isTabletScreen() ? 0.5 : 0.60;
  }

  static double getChildAspectRatioPoint75() {
    return _isTabletScreen() ? 0.6 : 0.75;
  }

  static double getChildAspectRatioPoint80() {
    return _isTabletScreen() ? 0.65 : 0.8;
  }

  static double getChildAspectRatioPoint85() {
    return _isTabletScreen() ? 0.67 : 0.85;
  }

  static double getChildAspectRatioPoint90() {
    return _isTabletScreen() ? 0.75 : 0.9;
  }

  static double getChildAspectRatioPoint95() {
    return _isTabletScreen() ? 0.8 : 0.95;
  }

  static double getChildAspectRatioPoint100() {
    return _isTabletScreen() ? 0.85 : 1;
  }
}
