import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;

  final Color? color;

  final double? wordSpacing;
  final VoidCallback? onClick;

  CustomText({
    Key? key,
    required this.text,
    this.size,
    this.fontWeight,
    this.color,
    this.wordSpacing,

    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            fontFamily: "Montserrat",
            color: color,
            fontSize: size,
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }
}
