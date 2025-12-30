import 'package:flutter/material.dart';


enum DeviceType { mobile, tablet, desktop }

enum ScreenSize { xs, sm, md, lg, xl }

class AppResponsive {
  static late double width;
  static late double height;

  static late DeviceType deviceType;
  static late ScreenSize screenSize;

  static late double _bw;
  static late double _bh;

  static void init(BuildContext context) {
    final mq = MediaQuery.of(context);
    width = mq.size.width;
    height = mq.size.height;

    _bw = width / 100;
    _bh = height / 100;

    deviceType = _getDeviceType(width);
    screenSize = _getScreenSize(width);
  }

  // % based sizing
  static double w(double v) => _bw * v;
  static double h(double v) => _bh * v;

  static DeviceType _getDeviceType(double w) {
    if (w >= 1024) return DeviceType.desktop;
    if (w >= 600) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  static ScreenSize _getScreenSize(double w) {
    if (w < 360) return ScreenSize.xs;
    if (w < 480) return ScreenSize.sm;
    if (w < 720) return ScreenSize.md;
    if (w < 1024) return ScreenSize.lg;
    return ScreenSize.xl;
  }
}
class AppFont {
  static double _scale(double size) {
    switch (AppResponsive.screenSize) {
      case ScreenSize.xs:
        return size * 0.85;
      case ScreenSize.sm:
        return size * 0.95;
      case ScreenSize.md:
        return size;
      case ScreenSize.lg:
        return size * 1.1;
      case ScreenSize.xl:
        return size * 1.25;
    }
  }

  static double get s12 => _scale(12);
  static double get s14 => _scale(14);
  static double get s16 => _scale(16);
  static double get s18 => _scale(18);
  static double get s20 => _scale(20);
  static double get s24 => _scale(24);
}
class AppRadius {
  static double get xs => AppResponsive.w(1);
  static double get sm => AppResponsive.w(2);
  static double get md => AppResponsive.w(3);
  static double get lg => AppResponsive.w(4);
  static double get xl => AppResponsive.w(5);
}
class AppIcon {
  static double _icon(double base) {
    switch (AppResponsive.screenSize) {
      case ScreenSize.xs:
        return base * 0.9;
      case ScreenSize.sm:
        return base;
      case ScreenSize.md:
        return base * 1.1;
      case ScreenSize.lg:
        return base * 1.25;
      case ScreenSize.xl:
        return base * 1.4;
    }
  }

  static double get sm => _icon(18);
  static double get md => _icon(24);
  static double get lg => _icon(32);
}
class AppSpacing {
  static double get xs => AppResponsive.w(2);
  static double get sm => AppResponsive.w(4);
  static double get md => AppResponsive.w(6);
  static double get lg => AppResponsive.w(8);
  static double get xl => AppResponsive.w(10);
}

