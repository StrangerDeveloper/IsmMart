

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../helper/api_base_helper.dart';
import '../../helper/global_variables.dart';
import '../../helper/urls.dart';

class LiveMatchViewModel extends GetxController{
  RxString liveUrl = ''.obs;
  RxBool isFullScreen = false.obs;

  RxList<String> imageList = <String>[
  ].obs;


  late YoutubePlayerController controller ;
  @override
  void onReady() {
    runSliderTimer();
    // TODO: implement onReady
    super.onReady();
  }
  @override
  void onInit() {
    getData();

    print('initialized');

    super.onInit();
  }
RxBool islive =false.obs;
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

        String? videoId="";
        videoId = YoutubePlayer.convertUrlToId("${liveUrl.value}")!;
        print("filtered ------$videoId"); // BBAyRBTfsOU
        liveUrl.value=videoId;
        print(" live Url --------  ${liveUrl.value}");
        controller= YoutubePlayerController(
          initialVideoId:liveUrl.value,
          flags: YoutubePlayerFlags(
            useHybridComposition: false,
            isLive: true,
          ),
        );
        islive.value=data[0]['live'];
        for(var img in  data[0]['images']){
          imageList.add(img['url']);
          print(img);
        }


      }  else if (parsedJson['success'] == false) {
        controller= YoutubePlayerController(
          initialVideoId:"Xx_hjshpLeU",
          flags: YoutubePlayerFlags(
            useHybridComposition: false,
            isLive: true,
          ),
        );
      }else {

        controller= YoutubePlayerController(
          initialVideoId:"Xx_hjshpLeU",
          flags: YoutubePlayerFlags(
            disableDragSeek: true,
            useHybridComposition: false,
            isLive: true,
          ),
        );
      }



    }).catchError((e) {
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }




 RxBool isSliderLoading=false.obs;
  RxInt indicatorIndex = 0.obs;
  late Timer? timer;
  var sliderPageController = PageController(initialPage: 0);

  void runSliderTimer() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (indicatorIndex.value < imageList.length) {
        indicatorIndex.value = indicatorIndex.value + 1;
      } else {
        indicatorIndex.value = 0;
      }
      if (sliderPageController.hasClients)
        sliderPageController.animateToPage(
          indicatorIndex.value,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOutCubicEmphasized,
        );
    });
  }


}