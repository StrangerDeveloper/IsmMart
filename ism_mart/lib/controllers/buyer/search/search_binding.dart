import 'package:get/get.dart';
import 'custom_search_controller.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    // : implement dependencies

    Get.lazyPut<CustomSearchController>(() => CustomSearchController(Get.find()));
  }
}
