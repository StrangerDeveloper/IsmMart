import 'package:get/get.dart';
import 'package:ism_mart/screens/search/search_viewmodel.dart';
import 'custom_search_controller.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomSearchController>(
        () => CustomSearchController(Get.find()));
    Get.lazyPut<SearchViewModel>(() => SearchViewModel(Get.find()));
  }
}
