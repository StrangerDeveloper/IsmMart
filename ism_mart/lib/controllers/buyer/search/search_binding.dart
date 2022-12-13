import 'package:get/get.dart';
import 'search_controller.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<SearchController>(() => SearchController(Get.find()));
  }
}
