import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboard_viewModel.dart';

class OnBoardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardViewModel>(
      init: OnBoardViewModel(), // Initializing the ViewModel
      builder: (viewModel) {
        return Scaffold(
          body: Container(
            height: 700,
            child: PageView.builder(
              controller: viewModel.pageController,
              onPageChanged: viewModel.onPageChanged,
              itemCount: 3,
              itemBuilder: (context, index) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //SvgPicture.asset(viewModel.list[index].image, height: 447, width: 347,),

                  Image.asset(
                    viewModel.list[index].image,
                    height: 449,
                    width: 346.5,
                  ),
                  // SvgPicture.asset(
                  //   viewModel.list[index].image,
                  //   height: 350,
                  // ),
                  SizedBox(height: 20),
                  Container(
                    width: 346,
                    child: Text(
                      viewModel.list[index].title,
                      style: GoogleFonts.dmSans(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF24282D)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 340,
                      child: Text(
                        viewModel.list[index].description,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF929AAB),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            height: 120,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    for (int i = 0; i < 3; i++)
                      viewModel.currentPage == i
                          ? pageIndicator(true)
                          : pageIndicator(false),
                  ],
                ),
                if (viewModel.currentPage < 2)
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        viewModel.goToNextPage();
                      },
                    ),
                  ),

                // Navigating to the BottomNavigationView when on the last onboarding screen
                if (viewModel.currentPage == 2)
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        viewModel.completeOnboarding();
                        viewModel.goToDashboard();
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget pageIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}
