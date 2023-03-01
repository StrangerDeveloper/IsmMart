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

  // container heights
  static double getHeight50_60() {
    return _isTabletScreen() ? 60 : 50;
  }
  static double getHeight50_100() {
    return _isTabletScreen() ? 100 : 50;
  }

  static double getHeight100_120() {
    return _isTabletScreen() ? 100 : 120;
  }
  static double getHeight100_150() {
    return _isTabletScreen() ? 150 : 100;
  }

  //container widths
  static double getWidth50() {
    return _isTabletScreen() ? 60 : 50;
  }

  /// box/section size

  static double getBoxHeightPoint15() {
    return height * (_isTabletScreen() ? 0.2 : 0.15);
  }

  static double getBoxHeightPoint22() {
    return height * (_isTabletScreen() ? 0.25 : 0.30);
  }


  static double getBoxHeightPoint25() {
    return height * (_isTabletScreen() ? 0.2 : 0.25);
  }

  static double getBoxHeightPoint30() {
    return height * (_isTabletScreen() ? 0.40 : 0.35);
  }

  static double getBoxHeightPoint55(){
    return height * (_isTabletScreen() ? 0.65 : 0.55);
  }



  ///Gridview contents

  static int getGridItemCount() {
    return _isTabletScreen() ? 3 : 2;
  }

  /// Gridview mainAxisExtent
  static double getMainAxisExtentPoint25() {
    return height * (_isTabletScreen() ? 0.30 : 0.25);
  }

  static double getMainAxisExtentPoint28() {
    return height * (_isTabletScreen() ? 0.32 : 0.28);
  }
}
