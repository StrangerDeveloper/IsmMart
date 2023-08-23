import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/screens/live_match/live_match_viewmodel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LiveMatchView extends StatelessWidget {
  const LiveMatchView({super.key});

  @override
  Widget build(BuildContext context) {
    final LiveMatchViewModel viewModel = Get.put(LiveMatchViewModel());

    return Obx(()=> viewModel.liveUrl.value.isNotEmpty? Scaffold(
      backgroundColor: newColorDarkBlack,
        body:Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .9,
            width: double.infinity,
            child: YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller:viewModel. controller,
                ),
                builder: (context, player){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // some widgets
                      YoutubePlayer(
                        controller:viewModel .controller,
                        liveUIColor: Colors.amber,
                      ),

                      // profileImage()
                    ],
                  );
                }
            ),
          ),
        )
    ): Scaffold(
      backgroundColor: newColorDarkBlack,
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 6.0,
          color: Colors.white,
        ),
      ),
    ),
    );
  }

  Widget profileImage() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),

        child:  Image.asset("assets/images/banner.jpeg"),
      ),
    );
  }
}
