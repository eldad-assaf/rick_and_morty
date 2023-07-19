import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/reuseable_text.dart';
import 'package:rick_and_morty/common/utils/text_style.dart';


class CustomOtlBtn extends StatelessWidget {
  const CustomOtlBtn({
    super.key,
    this.onTap,
    required this.width,
    required this.height,
    required this.color,
    this.color2,
    required this.text,
  });

  final void Function()? onTap;
  final double width;
  final double height;
  final Color color;
  final Color? color2;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color2,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            border: Border.all(width: 1, color: color),
          ),
          child: Center(
            child: ReusableText(
                text: text, style: appStyle(18, color, FontWeight.bold)),
          ),
        ));
  }
}
