import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/common/utils/constants.dart';
import 'package:rick_and_morty/common/utils/text_style.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Appconst.kPink),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'loading...',
            style: appStyle(24, Appconst.kBlueLight, FontWeight.normal),
          )
        ],
      ),
    );
  }
}
