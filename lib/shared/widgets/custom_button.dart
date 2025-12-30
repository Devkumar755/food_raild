import 'package:flutter/material.dart';

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
    this.padding,
    this.contentAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // --- RESPONSIVE DEFAULTS ---
    final double effectiveHeight = height ?? _responsiveHeight();
    final double effectiveRadius = borderRadius ?? AppRadius.md;
    final double effectiveElevation = elevation ?? 0;
    final double effectiveBorderWidth = borderWidth ?? AppResponsive.w(0.4);

    Color effectiveBg = backgroundColor ??
        (type == ButtonType.elevated
            ? theme.primaryColor
            : Colors.transparent);

    Color effectiveFg = foregroundColor ??
        (type == ButtonType.elevated
            ? Colors.white
            : theme.primaryColor);

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
      padding: WidgetStateProperty.all(_determinePadding()),
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

  // ---------------------------------------------------------------------------
  // RESPONSIVE HELPERS
  // ---------------------------------------------------------------------------

  double _responsiveHeight() {
    switch (AppResponsive.screenSize) {
      case ScreenSize.xs:
        return 42;
      case ScreenSize.sm:
        return 46;
      case ScreenSize.md:
        return 50;
      case ScreenSize.lg:
        return 54;
      case ScreenSize.xl:
        return 58;
    }
  }

  EdgeInsetsGeometry _determinePadding() {
    if (padding != null) return padding!;

    if (layout == ButtonLayout.iconOnly) {
      return EdgeInsets.all(AppSpacing.sm);
    }

    return EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.sm,
    );
  }

  // ---------------------------------------------------------------------------
  // CHILD BUILDERS
  // ---------------------------------------------------------------------------

  Widget _buildChild(Color color, double height) {
    if (isLoading) {
      return SizedBox(
        height: height * 0.45,
        width: height * 0.45,
        child: CircularProgressIndicator(
          strokeWidth: AppResponsive.w(0.6),
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
            ? [textWidget, SizedBox(width: AppSpacing.sm), iconWidget]
            : [iconWidget, SizedBox(width: AppSpacing.sm), textWidget],
      );
    }

    return _buildText();
  }

  Widget _buildIcon(Color color) {
    if (customIcon != null) return customIcon!;

    return Icon(
      icon ?? Icons.help_outline,
      color: iconColor ?? color,
      size: iconSize ?? AppIcon.md,
    );
  }

  Widget _buildText() {
    return Text(
      text ?? '',
      textAlign: TextAlign.center,
      style: (textStyle ?? const TextStyle()).copyWith(
        fontSize: textStyle?.fontSize ?? AppFont.s16,
        fontWeight: textStyle?.fontWeight ?? FontWeight.w600,
      ),
    );
  }
}
