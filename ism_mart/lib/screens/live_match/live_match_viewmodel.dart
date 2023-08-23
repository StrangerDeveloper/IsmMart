

import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../helper/api_base_helper.dart';
import '../../helper/global_variables.dart';
import '../../helper/urls.dart';

class LiveMatchViewModel extends GetxController{
RxString liveUrl = ''.obs;
 String a='qSldLOVjrYw';

final YoutubePlayerController controller = YoutubePlayerController(
  initialVideoId:'qSldLOVjrYw',
  flags: YoutubePlayerFlags(
    isLive: true,
  ),
);
  @override
  void onInit() {
    print('initialized');
    getData();
    a=liveUrl.value;
    super.onInit();
  }

  getData() async{
    GlobalVariable.showLoader.value = true;

    print('calling function');
    await ApiBaseHelper()
        .getMethod(url: Urls.liveMatch, withAuthorization: true)
        .then((parsedJson) {
          print('Inside then');
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true) {
        var data = parsedJson['data'] as List;

        liveUrl.value=data[0]['url'];
        print(" live Url --------  ${liveUrl.value}");
      }
    }).catchError((e) {
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }

}