import 'package:get/get.dart';
import 'package:ism_mart/screens/top_vendors/top_vendors_model.dart';

import '../../../controllers/buyer/auth/auth_controller.dart';
import '../../../models/user/country_city_model.dart';

class CityViewModel extends GetxController {
  final AuthController authController;

  CityViewModel(
    this.authController,
  );

  Rx<TopVendorsModel> topVendorsModel = TopVendorsModel().obs;

  @override
  void onReady() {
    // getCountryApi();
    // TODO: implement onReady
    super.onReady();
  }

  // // RxList<CountryModel> getCountryList = <CountryModel>[].obs;
  // var countryModel = CountryModel().obs;
  // RxList<CountryModel> getCountryList = <CountryModel>[].obs;
  // RxString selectedCountry = "abc".obs;
  // RxList<String> getCountryname = <String>[].obs;
  // getCountryApi() {
  //   // GlobalVariable.showLoader.value = true;
  //   ApiBaseHelper()
  //       .getMethod(url: Urls.getcountry, withBearer: false)
  //       .then((parsedJson) {
  //     GlobalVariable.showLoader.value = false;
  //     if (parsedJson['success'] == true) {
  //       var data = parsedJson['data'] as List;

  //       getCountryList.addAll(data.map((e) {
  //         //store only country names
  //         getCountryname.add(e["name"].toString());
  //         selectedCountry.value = getCountryname[0];

  //         return CountryModel.fromJson(e);
  //       }));
  //       // print("hasnain get  countryname $getCountryname");
  //       getCountryname
  //           .map((element) => print("hasnain get  map ${element}"))
  //           .toList();
  //       // print('hasnain get country >> ${getCountryList[0].name}  ');
  //     }
  //   }).catchError((e) {
  //     print(e);
  //     GlobalVariable.showLoader.value = false;
  //   });
  // }

  var countryId = 0.obs;
  var cityId = 0.obs;
  var selectedCountry = CountryModel().obs;
  var selectedCity = CountryModel().obs;
  void setSelectedCountry(CountryModel? model) async {
    authController.selectedCountry(model);
    //getCityByCountryName(name);
    countryId(model!.id);
    authController.cities.clear();
    // authController.update();
    await authController.getCitiesByCountry(countryId: model.id!);
  }

  void getCityByCountryName(String name) {
    if (authController.countries.isNotEmpty) {
      int? cId = authController.countries
          .firstWhere(
              (element) => element.name!.toLowerCase() == name.toLowerCase(),
              orElse: () => CountryModel())
          .id;
      countryId(cId!);
      authController.getCitiesByCountry(countryId: cId);
    }
  }

  RxString selectedcity = ''.obs;
  void setSelectedCity(CountryModel model) {
    authController.selectedCity(model);
    cityId(model.id);
    //  print("city id ======>${model.id}> ${cityId.value}");
    //getCityIdByName(value);
  }

  getCityIdByName(String? city) {
    print("cityyy ---- $city");
    // selectedcity.value = city.;
    cityId(authController.cities.isNotEmpty
        ? authController.cities
            .firstWhere(
                (element) => element.name!.toLowerCase() == city!.toLowerCase())
            .id
        : 0);
  }
}
