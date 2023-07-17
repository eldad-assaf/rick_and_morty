import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/common/utils/constants.dart';
import 'package:rick_and_morty/common/utils/text_style.dart';

import '../screens/character_details_screen.dart';

//This animation is for when the user add or remove a character from 'favourites'
//after pressing the 'heart' icon
class AddRemoveFromFavsAnimation extends StatefulWidget {
  final AnimationType animationType; // add or remove
  final String title;
  final String subTitle;
  final Widget child;
  const AddRemoveFromFavsAnimation({
    super.key,
    required this.animationType,
    required this.title,
    required this.subTitle,
    required this.child,
  });

  @override
  State<AddRemoveFromFavsAnimation> createState() =>
      _AddRemoveFromFavsAnimationState();
}

class _AddRemoveFromFavsAnimationState extends State<AddRemoveFromFavsAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> iconScaleAnimation;
  late Animation<double> containerScaleAnimation;
  late Animation<Offset> yAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    yAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.23),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    iconScaleAnimation = Tween<double>(begin: 7, end: 6).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    containerScaleAnimation =
        Tween<double>(begin: 2.0, end: 0.4).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller
      ..reset
      ..forward();
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 100.w,
            minHeight: 100.h,
            maxHeight: Appconst.kHeight * 0.8,
            maxWidth: Appconst.kWidth * 0.8,
          ),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 160.h,
                  ),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: appStyle(
                        30,
                        widget.animationType == AnimationType.add
                            ? Appconst.kGreen
                            : Appconst.kred,
                        FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    widget.subTitle,
                    textAlign: TextAlign.center,
                    style: appStyle(20, Appconst.kGreyDk, FontWeight.bold),
                  ),
                ],
              ),
            ),
            Positioned.fill(
                child: SlideTransition(
              position: yAnimation,
              child: ScaleTransition(
                scale: containerScaleAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.animationType == AnimationType.add
                        ? Appconst.kGreen
                        : Appconst.kred,
                  ),
                  child: ScaleTransition(
                    scale: iconScaleAnimation,
                    child: widget.child,
                  ),
                ),
              ),
            ))
          ]),
        ),
      ),
    );
  }
}
