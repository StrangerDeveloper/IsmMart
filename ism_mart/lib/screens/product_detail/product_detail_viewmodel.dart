import 'package:get/get.dart';

class ProductDetailViewModel extends GetxController {
  RxInt indicatorIndex = 0.obs;
  List<String> imageList = <String>[
    'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80',
    'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80',
    'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80'
  ].obs;

  RxInt selectedSize = 0.obs;
  List<String> sizeList =
      <String>['S', 'M', 'L', 'XL', 'S', 'M', 'L', 'XL'].obs;

  RxInt selectedColor = 0.obs;
  List<String> colorList = <String>['FFFFFF', '000000', 'CADCA7', 'F79F1F'].obs;
}
