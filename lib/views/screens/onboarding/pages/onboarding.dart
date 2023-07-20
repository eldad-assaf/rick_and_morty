import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/views/screens/onboarding/widgets/page_one.dart';
import 'package:rick_and_morty/views/screens/onboarding/widgets/page_two.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/reuseable_text.dart';
import '../../../../common/utils/constants.dart';
import '../../../../common/utils/text_style.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  static Page<void> page() => const MaterialPage<void>(child: Onboarding());

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: pageController,
          children: const [PageOne(), LoginPage()],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.ease);
                        },
                        child: const Icon(
                          //Ionicons.chevron_forward_circle,
                          Icons.forward,
                          size: 30,
                          color: Appconst.kLight,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ReusableText(
                          text: 'Signup or Login',
                          style:
                              appStyle(16, Appconst.kLight, FontWeight.w500)),
                    ],
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 2,
                    effect: const WormEffect(
                        activeDotColor: Appconst.kBlueLight,
                        dotHeight: 12,
                        dotWidth: 16,
                        spacing: 10,
                        dotColor: Appconst.kLight),
                  )
                ],
              )),
        )
      ]),
    );
  }
}
