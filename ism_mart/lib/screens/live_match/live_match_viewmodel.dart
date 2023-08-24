import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../helper/api_base_helper.dart';
import '../../helper/global_variables.dart';
import '../../helper/urls.dart';

class LiveMatchViewModel extends GetxController{

  RxString liveUrl = ''.obs;
 late YoutubePlayerController controller ;

 @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  @override
  void onClose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    super.onClose();
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

        liveUrl.value= data[0]['url'];
        String videoId;
        videoId = YoutubePlayer.convertUrlToId("${liveUrl.value}")!;
        print("filtered ------$videoId"); // BBAyRBTfsOU
        liveUrl.value=videoId;
        print(" live Url --------  ${liveUrl.value}");
        controller= YoutubePlayerController(
          initialVideoId:liveUrl.value,
          flags: YoutubePlayerFlags(
            isLive: true,
          ),
        );
      } else if (parsedJson['success'] == false){
        controller= YoutubePlayerController(
          initialVideoId:"3ed3bLXkqoA",
          flags: YoutubePlayerFlags(
            isLive: true,
          ),
        );
      }
    }).catchError((e) {
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }
}