import 'package:flutter/material.dart';
import '../../core/resources/app_colors.dart';
import '../../core/utils/responsive_layout.dart';


class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool readOnly;
  final InputBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final Color? fillColor;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.border,
    this.contentPadding,
    this.textStyle,
    this.fillColor,
  });

  @override
  State<CustomTextFormField> createState() =>
      _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _isObscured,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      style: widget.textStyle ??
          TextStyle(
            fontSize: AppFont.s14,
            color: AppColors.secondaryFontColor,
          ),
      decoration: _decoration(context),
    );
  }

  // ---------------------------------------------------------------------------
  // INPUT DECORATION
  // ---------------------------------------------------------------------------

  InputDecoration _decoration(BuildContext context) {
    final radius = AppRadius.md;

    return InputDecoration(
      hintText: widget.hintText,
      labelText: widget.labelText,

      filled: true,
      fillColor: widget.fillColor ?? AppColors.placeholderColor,

      hintStyle: TextStyle(
        fontSize: AppFont.s14,
        color: AppColors.secondaryFontColor.withValues(alpha: 0.7),
      ),

      labelStyle: TextStyle(
        fontSize: AppFont.s14,
        color: AppColors.secondaryFontColor,
      ),

      prefixIcon: _wrapIcon(widget.prefixIcon),
      suffixIcon: _buildSuffixIcon(),

      contentPadding: widget.contentPadding ??
          EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),

      border: widget.border ?? _outlineBorder(radius, AppColors.primaryColor),
      enabledBorder:
          widget.border ?? _outlineBorder(radius, AppColors.secondaryFontColor),
      focusedBorder: widget.border ??
          _outlineBorder(
            radius,
            AppColors.primaryColor,
            width: AppResponsive.w(0.6),
          ),
      errorBorder:
          _outlineBorder(radius, Colors.red, width: AppResponsive.w(0.6)),
      focusedErrorBorder:
          _outlineBorder(radius, Colors.red, width: AppResponsive.w(0.6)),
    );
  }

  // ---------------------------------------------------------------------------
  // SUFFIX ICON LOGIC (PASSWORD TOGGLE)
  // ---------------------------------------------------------------------------

  Widget? _buildSuffixIcon() {

    if (widget.suffixIcon != null) {
      return _wrapIcon(widget.suffixIcon);
    }

    if (!widget.obscureText) return null;

    return IconButton(
      splashRadius: AppSpacing.lg,
      icon: Icon(
        _isObscured ? Icons.visibility_off : Icons.visibility,
        size: AppIcon.md,
        color: AppColors.secondaryFontColor,
      ),
      onPressed: () {
        setState(() {
          _isObscured = !_isObscured;
        });
      },
    );
  }

  // ---------------------------------------------------------------------------
  // HELPERS
  // ---------------------------------------------------------------------------

  OutlineInputBorder _outlineBorder(
    double radius,
    Color color, {
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  Widget? _wrapIcon(Widget? icon) {
    if (icon == null) return null;

    return Padding(
      padding: EdgeInsets.all(AppSpacing.sm),
      child: IconTheme(
        data: IconThemeData(
          size: AppIcon.md,
          color: AppColors.secondaryFontColor,
        ),
        child: icon,
      ),
    );
  }
}



