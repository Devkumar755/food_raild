import 'package:flutter/material.dart';
import 'package:food_rail/core/dependency_injection.dart';
import 'package:get/get.dart';

import 'core/routes/app_pages.dart';
import 'core/utils/responsive_layout.dart';
import 'shared/themes.dart';

void main() {

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Food Rail",
      initialRoute: AppRoutes.splash,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.light,
      getPages: AppPages.getAppPages,
      initialBinding: DependencyInjection(),
    ),
  );
}
