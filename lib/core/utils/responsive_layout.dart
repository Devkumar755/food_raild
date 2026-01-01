import 'dart:math' as math;

import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop, tv }

enum ScreenSize { xs, sm, md, lg, xl, xxl }

enum Orientation { portrait, landscape }

class ResponsiveBreakpoints {
  static const double mobile = 550;
  static const double tablet = 550;
  static const double desktop = 1200;
  static const double tv = 1800;

  static const double xs = 0;
  static const double sm = 576;
  static const double md = 768;
  static const double lg = 992;
  static const double xl = 1200;
  static const double xxl = 1400;
}

class ScreenInfo {
  final double width;
  final double height;
  final double diagonal;
  final double pixelRatio;
  final DeviceType deviceType;
  final ScreenSize screenSize;
  final Orientation orientation;
  final bool isPortrait;
  final bool isLandscape;
  final EdgeInsets padding;
  final EdgeInsets viewInsets;

  const ScreenInfo({
    required this.width,
    required this.height,
    required this.diagonal,
    required this.pixelRatio,
    required this.deviceType,
    required this.screenSize,
    required this.orientation,
    required this.isPortrait,
    required this.isLandscape,
    required this.padding,
    required this.viewInsets,
  });

  factory ScreenInfo.fromContext(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final width = size.width;
    final height = size.height;
    final diagonal = math.sqrt(width * width + height * height);
    final pixelRatio = mediaQuery.devicePixelRatio;
    final isPortrait = height > width;

    return ScreenInfo(
      width: width,
      height: height,
      diagonal: diagonal,
      pixelRatio: pixelRatio,
      deviceType: _getDeviceType(width),
      screenSize: _getScreenSize(width),
      orientation: isPortrait ? Orientation.portrait : Orientation.landscape,
      isPortrait: isPortrait,
      isLandscape: !isPortrait,
      padding: mediaQuery.padding,
      viewInsets: mediaQuery.viewInsets,
    );
  }

  static DeviceType _getDeviceType(double width) {
    if (width >= ResponsiveBreakpoints.tv) return DeviceType.tv;
    if (width >= ResponsiveBreakpoints.desktop) return DeviceType.desktop;
    if (width >= ResponsiveBreakpoints.mobile)
      return DeviceType.tablet; // 550px and above = tablet
    return DeviceType.mobile; // Below 550px = mobile
  }

  static ScreenSize _getScreenSize(double width) {
    if (width >= ResponsiveBreakpoints.xxl) return ScreenSize.xxl;
    if (width >= ResponsiveBreakpoints.xl) return ScreenSize.xl;
    if (width >= ResponsiveBreakpoints.lg) return ScreenSize.lg;
    if (width >= ResponsiveBreakpoints.md) return ScreenSize.md;
    if (width >= ResponsiveBreakpoints.sm) return ScreenSize.sm;
    return ScreenSize.xs;
  }
}

class ResponsiveManager {
  static ScreenInfo getScreenInfo(BuildContext context) {
    return ScreenInfo.fromContext(context);
  }

  static bool isMobile(BuildContext context) =>
      getScreenInfo(context).deviceType == DeviceType.mobile;

  static bool isTablet(BuildContext context) =>
      getScreenInfo(context).deviceType == DeviceType.tablet;

  static bool isDesktop(BuildContext context) =>
      getScreenInfo(context).deviceType == DeviceType.desktop;

  static bool isTV(BuildContext context) =>
      getScreenInfo(context).deviceType == DeviceType.tv;
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ScreenInfo screenInfo) builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return builder(context, context.screenInfo);
  }
}

extension ResponsiveContext on BuildContext {
  ScreenInfo get screenInfo => ResponsiveManager.getScreenInfo(this);

  bool get isMobile => screenInfo.deviceType == DeviceType.mobile;
  bool get isTablet => screenInfo.deviceType == DeviceType.tablet;
  bool get isDesktop => screenInfo.deviceType == DeviceType.desktop;
  bool get isTV => screenInfo.deviceType == DeviceType.tv;

  bool get isPortrait => screenInfo.isPortrait;
  bool get isLandscape => screenInfo.isLandscape;

  double get screenWidth => screenInfo.width;
  double get screenHeight => screenInfo.height;

  T responsive<T>(ResponsiveValue<T> value) => value.getValue(screenInfo);
}

class ResponsiveValue<T> {
  final T? xs;
  final T? sm;
  final T? md;
  final T? lg;
  final T? xl;
  final T? xxl;
  final T? mobile;
  final T? tablet;
  final T? desktop;
  final T? tv;
  final T defaultValue;

  const ResponsiveValue({
    required this.defaultValue,
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
    this.mobile,
    this.tablet,
    this.desktop,
    this.tv,
  });

  T getValue(ScreenInfo screenInfo) {
    // Try device type first
    switch (screenInfo.deviceType) {
      case DeviceType.tv:
        if (tv != null) return tv!;
        break;
      case DeviceType.desktop:
        if (desktop != null) return desktop!;
        break;
      case DeviceType.tablet:
        if (tablet != null) return tablet!;
        break;
      case DeviceType.mobile:
        if (mobile != null) return mobile!;
        break;
    }

    // Then try screen size breakpoints
    switch (screenInfo.screenSize) {
      case ScreenSize.xxl:
        if (xxl != null) return xxl!;
        continue xl;
      xl:
      case ScreenSize.xl:
        if (xl != null) return xl!;
        continue lg;
      lg:
      case ScreenSize.lg:
        if (lg != null) return lg!;
        continue md;
      md:
      case ScreenSize.md:
        if (md != null) return md!;
        continue sm;
      sm:
      case ScreenSize.sm:
        if (sm != null) return sm!;
        continue xs;
      xs:
      case ScreenSize.xs:
        if (xs != null) return xs!;
        break;
    }

    return defaultValue;
  }
}

// enum DeviceType { mobile, tablet, desktop }
//
// enum ScreenSize { xs, sm, md, lg, xl }
//
// class AppResponsive {
//   static late double width;
//   static late double height;
//
//   static late DeviceType deviceType;
//   static late ScreenSize screenSize;
//
//   static late double _bw;
//   static late double _bh;
//
//   static void init(BuildContext context) {
//     final mq = MediaQuery.of(context);
//     width = mq.size.width;
//     height = mq.size.height;
//
//     _bw = width / 100;
//     _bh = height / 100;
//
//     deviceType = _getDeviceType(width);
//     screenSize = _getScreenSize(width);
//   }
//
//   // % based sizing
//   static double w(double v) => _bw * v;
//   static double h(double v) => _bh * v;
//
//   static DeviceType _getDeviceType(double w) {
//     if (w >= 1024) return DeviceType.desktop;
//     if (w >= 600) return DeviceType.tablet;
//     return DeviceType.mobile;
//   }
//
//   static ScreenSize _getScreenSize(double w) {
//     if (w < 360) return ScreenSize.xs;
//     if (w < 480) return ScreenSize.sm;
//     if (w < 720) return ScreenSize.md;
//     if (w < 1024) return ScreenSize.lg;
//     return ScreenSize.xl;
//   }
// }
// class AppFont {
//   static double _scale(double size) {
//     switch (AppResponsive.screenSize) {
//       case ScreenSize.xs:
//         return size * 0.85;
//       case ScreenSize.sm:
//         return size * 0.95;
//       case ScreenSize.md:
//         return size;
//       case ScreenSize.lg:
//         return size * 1.1;
//       case ScreenSize.xl:
//         return size * 1.25;
//     }
//   }
//
//   static double get s12 => _scale(12);
//   static double get s14 => _scale(14);
//   static double get s16 => _scale(16);
//   static double get s18 => _scale(18);
//   static double get s20 => _scale(20);
//   static double get s24 => _scale(24);
// }
// class AppRadius {
//   static double get xs => AppResponsive.w(1);
//   static double get sm => AppResponsive.w(2);
//   static double get md => AppResponsive.w(3);
//   static double get lg => AppResponsive.w(4);
//   static double get xl => AppResponsive.w(5);
// }
// class AppIcon {
//   static double _icon(double base) {
//     switch (AppResponsive.screenSize) {
//       case ScreenSize.xs:
//         return base * 0.9;
//       case ScreenSize.sm:
//         return base;
//       case ScreenSize.md:
//         return base * 1.1;
//       case ScreenSize.lg:
//         return base * 1.25;
//       case ScreenSize.xl:
//         return base * 1.4;
//     }
//   }
//
//   static double get sm => _icon(18);
//   static double get md => _icon(24);
//   static double get lg => _icon(32);
// }
// class AppSpacing {
//   static double get xs => AppResponsive.w(2);
//   static double get sm => AppResponsive.w(4);
//   static double get md => AppResponsive.w(6);
//   static double get lg => AppResponsive.w(8);
//   static double get xl => AppResponsive.w(10);
// }
