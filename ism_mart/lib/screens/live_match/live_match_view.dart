







import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/screens/dashboard/dashboard_viewmodel.dart';
import 'package:ism_mart/screens/live_match/live_match_viewmodel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../widgets/custom_loading.dart';

class LiveMatchView extends StatelessWidget {
   LiveMatchView({super.key});
  final LiveMatchViewModel viewModel = Get.put(LiveMatchViewModel());
  final DashboardViewModel viewModelD = Get.put(DashboardViewModel());

  @override
  Widget build(BuildContext context) {

    var h= MediaQuery.of(context).size.height;
    var w= MediaQuery.of(context).size.width;

    return Obx(()=> viewModel.liveUrl.value.isNotEmpty? Scaffold(
      backgroundColor: Colors.black,
        body:Column(
          children: [
            Expanded(
              child: YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller:viewModel. controller,
                  ),
                  builder: (context, player){
                    return player;
                  }



              ),
            ),
            Expanded(child: _slider(h,w )),
            // SizedBox(height: 10,),
            // chatWidget1(),
            // SizedBox(height: 10,),
            // backButton(),
          ],
        )  ):Scaffold(body: Center(child: CircularProgressIndicator(color: newColorDarkBlack,),)
      ,),
    );}



  //icon button
  Widget backButton() {
    return IconButton(onPressed: (){
      Get.back();
    }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,size: 25,));
  }





  //chat
   Widget chatWidget1() {
     return Positioned(
       bottom: 12,
       right: 10,
       child: SlideTransition(
         position: viewModelD.animation1,
         child: GestureDetector(
           onTap: () async {
             Get.to(()=> LiveMatchView());
             //  Get.toNamed(Routes.chatScreen);
             // await viewModel.getCurrentLocation();
           },
           child: Obx(
                 () =>viewModel.islive.value ==false ?  AnimatedContainer(
               width: 250,
               height: 40,
               decoration: BoxDecoration(
                   border: Border.all(
                       width: 1.5,
                       color: Colors.red
                   ),
                   color: Colors.white,
                   // color: Color(0xff3769CA),
                   borderRadius: BorderRadius.all(Radius.circular(28)),
                   boxShadow: [
                     BoxShadow(
                         color: Colors.grey.withOpacity(0.2),
                         offset: Offset(0, 3),
                         blurRadius: 1,
                         spreadRadius: 1)
                   ]),
               duration: Duration.zero,
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 13.0),
                 child: FadeTransition(
                   opacity: viewModelD.animation4,
                   child:  SizedBox(
                     height: 50,
                     width: 250,
                     child: Text(
                       textAlign:TextAlign.center,
                       maxLines:2,
                       "We get back with live-stream ones, The Match Starts",
                       style: TextStyle(
                           color: Colors.red,
                           fontWeight: FontWeight.w600,
                           fontSize: 14),
                     ),
                   ),
                 ),


                ),
                   ):SizedBox(),

           ),
         ),
       ),
     );
   }


   //slider




   Widget _slider( h,w) {
     return Obx(
           () => viewModel .isSliderLoading.isTrue
           ? CustomLoading(isItForWidget: true)
           : Stack(
         alignment: Alignment.bottomCenter,
         children: [
           PageView.builder(
             controller: viewModel .sliderPageController,
             onPageChanged: (value) {
               viewModel.sliderIndex(value);
             },
             itemCount:viewModel. sliderImages.length,
             itemBuilder: (context, index) {
               return Image.asset(viewModel.sliderImages[index].toString());
             },
           ),
           Padding(
             padding: EdgeInsets.only(bottom: 6),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: List.generate(
                 viewModel.sliderImages.length,
                     (index) => AnimatedContainer(
                   duration: const Duration(milliseconds: 400),
                   height: 6.0,
                   width: viewModel.sliderIndex.value == index ? 14 : 6,
                   margin: const EdgeInsets.only(right: 3),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(5),
                     color: viewModel.sliderIndex.value == index
                         ? Colors.black
                         : Colors.grey,
                   ),
                 ),
               ),
             ),
           ),
         ],
       ),

     );
   }




}