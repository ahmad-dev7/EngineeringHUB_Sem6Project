import 'package:flutter/material.dart';

class KMyText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final int? maxLines;
  const KMyText(
    this.text, {
    super.key,
    this.color,
    this.size,
    this.weight,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow ?? TextOverflow.visible,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}
