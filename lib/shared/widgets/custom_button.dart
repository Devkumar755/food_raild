import 'package:flutter/material.dart';
import 'package:food_rail/core/resources/app_colors.dart';

import '../../core/utils/responsive_layout.dart';

/// 1. Defines the Visual Style (Background, Border, Shadow)
enum ButtonType { elevated, outlined, text }

/// 2. Defines the Content Layout (Explicit control over what shows)
enum ButtonLayout { textOnly, iconOnly, iconWithText }

class CustomButton extends StatelessWidget {
  // --- Core Configuration ---
  final VoidCallback? onPressed;
  final String? text;
  final ButtonType type;
  final ButtonLayout layout;
  final bool isLoading;
  final bool isDisabled;

  // --- Icon Configuration ---
  final IconData? icon;
  final Widget? customIcon;
  final double? iconSize;
  final Color? iconColor;
  final bool isIconTrailing;

  // --- Styling Overrides ---
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final double? elevation;
  final TextStyle? textStyle;

  // --- Sizing & Padding ---
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment contentAlignment;

  const CustomButton({
    super.key,
    required this.onPressed,
    this.text,
    this.type = ButtonType.elevated,
    this.layout = ButtonLayout.textOnly,
    this.isLoading = false,
    this.isDisabled = false,

    // Icon
    this.icon,
    this.customIcon,
    this.iconSize,
    this.iconColor,
    this.isIconTrailing = false,

    // Styling
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.elevation,
    this.textStyle,

    // Layout
    this.width,
    this.height,
    this.padding = EdgeInsets.zero,
    this.contentAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // --- RESPONSIVE DEFAULTS ---
    final double effectiveHeight = height ?? 58;
    final double effectiveRadius = borderRadius ?? 20;
    final double effectiveElevation = elevation ?? 0;
    final double effectiveBorderWidth = borderWidth ?? 0.4;

    Color effectiveBg = backgroundColor ??
        (type == ButtonType.elevated
            ? theme.primaryColor
            : Colors.transparent);

    Color effectiveFg = foregroundColor ??
        (type == ButtonType.elevated
            ? Colors.white
            : AppColors.primaryFontColor);

    Color effectiveBorder = borderColor ??
        (type == ButtonType.outlined ? effectiveFg : Colors.transparent);

    if (isDisabled) {
      effectiveBg = Colors.grey.shade300;
      effectiveFg = Colors.grey.shade500;
      effectiveBorder = Colors.transparent;
    }

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(effectiveRadius),
      side: type == ButtonType.outlined || borderColor != null
          ? BorderSide(color: effectiveBorder, width: effectiveBorderWidth)
          : BorderSide.none,
    );

    final ButtonStyle style = ButtonStyle(
      elevation: WidgetStateProperty.all(
          type == ButtonType.elevated ? effectiveElevation : 0),
      backgroundColor: WidgetStateProperty.all(effectiveBg),
      foregroundColor: WidgetStateProperty.all(effectiveFg),
      shape: WidgetStateProperty.all(shape),
      minimumSize:
          WidgetStateProperty.all(Size(width ?? 0, effectiveHeight)),
      overlayColor: type != ButtonType.elevated
          ? WidgetStateProperty.all(effectiveFg.withValues(alpha: 0.1))
          : null,
    );

    return SizedBox(
      width: width,
      height: effectiveHeight,
      child: IgnorePointer(
        ignoring: isDisabled || isLoading,
        child: ElevatedButton(
          onPressed: onPressed,
          style: style,
          child: _buildChild(effectiveFg, effectiveHeight),
        ),
      ),
    );
  }



  Widget _buildChild(Color color, double height) {
    if (isLoading) {
      return SizedBox(
        height: height * 0.45,
        width: height * 0.45,
        child: CircularProgressIndicator(
          strokeWidth: 0.6,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      );
    }

    if (layout == ButtonLayout.iconOnly) {
      return _buildIcon(color);
    }

    if (layout == ButtonLayout.iconWithText) {
      final iconWidget = _buildIcon(color);
      final textWidget = _buildText();

      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: contentAlignment,
        children: isIconTrailing
            ? [textWidget, SizedBox(width: 10), iconWidget]
            : [iconWidget, SizedBox(width: 10), textWidget],
      );
    }

    return _buildText();
  }

  Widget _buildIcon(Color color) {
    if (customIcon != null) return customIcon!;

    return Icon(
      icon ?? Icons.help_outline,
      color: iconColor ?? color,
      size: iconSize ?? 20,
    );
  }

  Widget _buildText() {
    return Text(
      text ?? '',
      textAlign: TextAlign.center,
      style: (textStyle ?? const TextStyle()).copyWith(
        fontSize: textStyle?.fontSize ?? 16,
        fontWeight: textStyle?.fontWeight ?? FontWeight.w600,

      ),
    );
  }
}
