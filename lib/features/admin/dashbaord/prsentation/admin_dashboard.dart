import 'package:flutter/material.dart';
import 'package:food_rail/features/admin/dashbaord/prsentation/controllers/admin_dash_controller.dart';
import 'package:food_rail/shared/widgets/responsive_scaffold.dart';
import 'package:get/get.dart';
import '../../../../core/utils/responsive_layout.dart';

class AdminDashboard extends StatelessWidget {
   AdminDashboard({super.key});

  final adminController = Get.find<AdminDashController>();
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      useSidebarX: true,
      persistentBreakpoint: ResponsiveBreakpoints.sm,
      body: Obx(() { return adminController.adminOutlates[adminController.currentIndex]; }),
       sidebarItems: adminController.getSidebarXItems(onItemTap: adminController.changeTab), drawerKey: adminController.scaffoldKey,
    );
  }
}
