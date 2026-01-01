import 'package:flutter/material.dart';

import '../../core/utils/responsive_layout.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;

  final double? letterSpacing;
  final double? height;

  final bool underline;
  final bool italic;

  const CustomText(
    this.text, {
    super.key,
    this.style,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.align,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.underline = false,
    this.italic = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow ,
      style: _resolveStyle(context),
    );
  }

  TextStyle _resolveStyle(BuildContext context) {
    final baseStyle = style ??
        Theme.of(context).textTheme.bodyMedium ??
        const TextStyle();

    return baseStyle.copyWith(
      fontSize: fontSize ?? baseStyle.fontSize ?? 14,
      fontWeight: fontWeight ?? baseStyle.fontWeight ?? FontWeight.w400,
      color: color ?? baseStyle.color,
      letterSpacing: letterSpacing ?? baseStyle.letterSpacing,
      height: height ?? baseStyle.height,
      fontStyle: italic ? FontStyle.italic : baseStyle.fontStyle,
      decoration:
          underline ? TextDecoration.underline : baseStyle.decoration,
    );
  }
}
