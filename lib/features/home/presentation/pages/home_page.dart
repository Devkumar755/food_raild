import 'package:flutter/material.dart';
import 'package:food_rail/features/home/presentation/controllers/home_controller.dart';
import 'package:food_rail/features/home/presentation/pages/widgets/bottom_navigation.dart';
import 'package:food_rail/shared/widgets/custom_text.dart';
import 'package:get/get.dart';

import '../../../../core/resources/app_colors.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controller.bottomOutlates[controller.currentIndex];
      }),
        bottomNavigationBar: CustomBottomNavigation(controller: controller)
    );
  }
}