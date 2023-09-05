// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// import '../../helper/api_base_helper.dart';
// import '../../helper/global_variables.dart';
// import '../../helper/urls.dart';
//
// class LiveMatchViewModel extends GetxController{
//   RxString liveUrl = ''.obs;
//   RxBool isFullScreen = false.obs;
//   RxBool islive =false.obs;
//   RxList<String> imageList = <String>[].obs;
//   late YoutubePlayerController controller;
//   RxBool isSliderLoading=false.obs;
//   RxInt indicatorIndex = 0.obs;
//   late Timer? timer;
//   var sliderPageController = PageController(initialPage: 0);
//
//   @override
//   void onInit() {
//     getData();
//     super.onInit();
//   }
//
//   @override
//   void onReady() {
//     runSliderTimer();
//     super.onReady();
//   }
//
//   @override
//   void onClose() {
//     timer?.cancel();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
//     super.onClose();
//   }
//
//   getData() async{
//     GlobalVariable.showLoader.value = true;
//
//     await ApiBaseHelper()
//         .getMethod(url: Urls.liveMatch, withAuthorization: true)
//         .then((parsedJson) {
//       GlobalVariable.showLoader.value = false;
//       if (parsedJson['success'] == true) {
//         var data = parsedJson['data'] as List;
//
//         liveUrl.value= data[0]['url'];
//         String? videoId="";
//         videoId = YoutubePlayer.convertUrlToId("${liveUrl.value}")!;
//         liveUrl.value=videoId;
//         controller= YoutubePlayerController(
//           initialVideoId:liveUrl.value,
//           flags: YoutubePlayerFlags(
//             disableDragSeek: true,
//             useHybridComposition: false,
//             isLive: true,
//               hideThumbnail: true
//           ),
//         );
//         islive.value=data[0]['live'];
//         for(var img in  data[0]['images']){
//           imageList.add(img['url']);
//         }
//       }  else if (parsedJson['success'] == false) {
//         controller= YoutubePlayerController(
//           initialVideoId:"Xx_hjshpLeU",
//           flags: YoutubePlayerFlags(
//             disableDragSeek: true,
//             useHybridComposition: false,
//             isLive: true,
//               hideThumbnail: true
//           ),
//         );
//       }else {
//
//         controller= YoutubePlayerController(
//           initialVideoId:"Xx_hjshpLeU",
//           flags: YoutubePlayerFlags(
//             disableDragSeek: true,
//             useHybridComposition: false,
//             isLive: true,
//             hideThumbnail: true
//           ),
//         );
//       }
//     }).catchError((e) {
//       print(e);
//       GlobalVariable.showLoader.value = false;
//     });
//   }
//
//   void runSliderTimer() {
//     timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
//       if (indicatorIndex.value < imageList.length) {
//         indicatorIndex.value = indicatorIndex.value + 1;
//       } else {
//         indicatorIndex.value = 0;
//       }
//       if (sliderPageController.hasClients)
//         sliderPageController.animateToPage(
//           indicatorIndex.value,
//           duration: const Duration(milliseconds: 350),
//           curve: Curves.easeInOutCubicEmphasized,
//         );
//     });
//   }
//
//
// }