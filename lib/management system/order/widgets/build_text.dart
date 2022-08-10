import 'package:flutter/material.dart';

class OrderBuildText extends StatelessWidget {
  OrderBuildText({
    Key? key,
    required this.text,
    required this.fontSize,
    this.fontWeight = FontWeight.w400,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
