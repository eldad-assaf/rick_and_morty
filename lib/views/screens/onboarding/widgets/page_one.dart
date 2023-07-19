import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/reuseable_text.dart';
import '../../../../common/utils/constants.dart';
import '../../../../common/utils/text_style.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Appconst.kHeight,
      width: Appconst.kWidth,
      color: Appconst.kBkDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(60.0), 
                child: Image.asset('assets/images/onboarding.png'),
              )),
          const SizedBox(height: 100),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReusableText(
                text: 'The Rick And Morty App',
                style: appStyle(30, Appconst.kLight, FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Text(
                  '“Welcome to club, pal.”',
                  textAlign: TextAlign.center,
                  style: appStyle(16, Appconst.kGreyLight, FontWeight.normal),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
