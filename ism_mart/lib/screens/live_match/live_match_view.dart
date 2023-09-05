// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ism_mart/screens/dashboard/dashboard_viewmodel.dart';
// import 'package:ism_mart/screens/live_match/live_match_viewmodel.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class LiveMatchView extends StatelessWidget {
//   LiveMatchView({super.key});
//   final LiveMatchViewModel viewModel = Get.put(LiveMatchViewModel());
//   final DashboardViewModel viewModelD = Get.put(DashboardViewModel());
//
//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//     var w = MediaQuery.of(context).size.width;
//     return Obx(
//       () => viewModel.liveUrl.value.isNotEmpty
//           ? SafeArea(
//               child: Scaffold(
//                   backgroundColor: Colors.black,
//                   body: Center(
//                     child: Obx(
//                       () => SizedBox(
//                         width: viewModel.isFullScreen.value
//                             ? w * 0.9
//                             : double.infinity,
//                         height: viewModel.isFullScreen.value
//                             ? h * 0.8
//                             : double.infinity,
//                         child: YoutubePlayerBuilder(
//                             onEnterFullScreen: () {
//                               viewModel.isFullScreen.value = true;
//                             },
//                             onExitFullScreen: () {
//                               viewModel.isFullScreen.value = false;
//                             },
//                             player: YoutubePlayer(
//                               controller: viewModel.controller,
//                             ),
//                             builder: (context, player) {
//                               return Obx(
//                                 () => viewModel.isFullScreen.value
//                                     ? player
//                                     : Stack(
//                                         children: [
//                                           Column(
//                                             children: [
//                                               Expanded(
//                                                 child: player,
//                                               ),
//                                               alertMsg(),
//                                               Expanded(
//                                                 child: carousel(),
//                                               ),
//                                             ],
//                                           ),
//                                           backButton(),
//                                         ],
//                                       ),
//                               );
//                             }),
//                       ),
//                     ),
//                   )),
//             )
//           : Scaffold(
//               backgroundColor: Colors.black,
//               body: Center(
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//     );
//   }
//
//   //icon button
//   Widget backButton() {
//     return IconButton(
//         onPressed: () {
//           Get.back();
//         },
//         icon: Icon(
//           Icons.arrow_back_ios,
//           color: Colors.white,
//           size: 25,
//         ));
//   }
//
//   //chat
//   Widget alertMsg() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: SlideTransition(
//         position: viewModelD.animation1,
//         child: Obx(
//           () => viewModel.islive.value == false
//               ? AnimatedContainer(
//                   width: 250,
//                   height: 40,
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 1.5, color: Colors.red),
//                       color: Colors.white,
//                       // color: Color(0xff3769CA),
//                       borderRadius: BorderRadius.all(Radius.circular(28)),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.grey.withOpacity(0.2),
//                             offset: Offset(0, 3),
//                             blurRadius: 1,
//                             spreadRadius: 1)
//                       ]),
//                   duration: Duration.zero,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 13.0),
//                     child: FadeTransition(
//                       opacity: viewModelD.animation4,
//                       child: SizedBox(
//                         height: 50,
//                         width: 250,
//                         child: Text(
//                           textAlign: TextAlign.center,
//                           maxLines: 2,
//                           "We'll be back with the live stream once the match starts.",
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 14),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               : SizedBox(),
//         ),
//       ),
//     );
//   }
//
//   //slider
//   Widget carousel() {
//     return Obx(
//       () => (viewModel.imageList.isNotEmpty)
//           ? Stack(
//               alignment: Alignment.bottomCenter,
//               children: [
//                 Obx(
//                   () => PageView.builder(
//                     controller: viewModel.sliderPageController,
//                     onPageChanged: (value) {
//                       viewModel.indicatorIndex(value);
//                     },
//                     itemCount: viewModel.imageList.length,
//                     itemBuilder: (context, index) {
//                       return mainImage(viewModel.imageList[index]);
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(bottom: 15),
//                   child: AnimatedSmoothIndicator(
//                     activeIndex: viewModel.indicatorIndex.value,
//                     count: viewModel.imageList.length,
//                     effect: CustomizableEffect(
//                       spacing: 12,
//                       dotDecoration: DotDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         width: 6,
//                         height: 6,
//                       ),
//                       activeDotDecoration: DotDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         dotBorder: DotBorder(
//                           padding: 3.2,
//                           color: Colors.white,
//                         ),
//                         width: 6,
//                         height: 6,
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             )
//           : SizedBox(),
//     );
//   }
//
//   Widget mainImage(String url) {
//     return CachedNetworkImage(
//       width: double.infinity,
//       imageUrl: url,
//       imageBuilder: (context, imageProvider) {
//         return Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: imageProvider,
//               fit: BoxFit.cover,
//             ),
//           ),
//         );
//       },
//       errorWidget: (context, url, error) {
//         return Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/no_image_found.jpg'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         );
//       },
//       placeholder: (context, url) {
//         return const Center(
//           child: CircularProgressIndicator(strokeWidth: 0.5),
//         );
//       },
//     );
//   }
// }
