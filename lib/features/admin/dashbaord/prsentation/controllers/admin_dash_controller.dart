import 'package:flutter/material.dart';
import 'package:food_rail/core/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:solar_icons/solar_icons.dart';

import '../../../../../core/routes/app_pages.dart';
import '../../../../home/domain/entities/bottom_navigation_model_item.dart';

class AdminDashController extends BaseController {
  final RxInt _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void changeTab(int index) {
    _currentIndex.value = index;
  }

  void toggleDrawer() {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.closeDrawer();
    } else {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  List<SidebarXItem> getSidebarXItems({
    required Function(int) onItemTap,
    bool includeExtended = false,
  }) {
    final items = getVisibleItems();
    return items.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      return item.toSidebarXItem(() {
        onItemTap(index);
        toggleDrawer();
      });
    }).toList();
  }

  List<BottomNavigationModelItem> getVisibleItems() {
    return [
      BottomNavigationModelItem(
        labelName: "Menu",
        routeId: AppRoutes.menu,
        inactiveIcon: SolarIconsOutline.widget_6,
        activeIcon: SolarIconsBold.widget_6,
        routeName: AppRoutes.menu,
      ),
      BottomNavigationModelItem(
        labelName: "Offers",
        routeId: AppRoutes.offers,
        inactiveIcon: SolarIconsOutline.confetti,
        activeIcon: SolarIconsBold.confettiMinimalistic,
        routeName: AppRoutes.offers,
      ),
      BottomNavigationModelItem(
        labelName: "Home",
        routeId: AppRoutes.dashboard,
        inactiveIcon: Icons.home_outlined,
        activeIcon: SolarIconsBold.home1,
        routeName: AppRoutes.dashboard,
      ),
      BottomNavigationModelItem(
        labelName: "Profile",
        routeId: AppRoutes.profile,
        inactiveIcon: SolarIconsOutline.user,
        activeIcon: SolarIconsBold.user,
        routeName: AppRoutes.profile,
      ),
      BottomNavigationModelItem(
        labelName: "More",
        routeId: AppRoutes.more,
        inactiveIcon: SolarIconsOutline.listDownMinimalistic,
        activeIcon: SolarIconsBold.listDownMinimalistic,
        routeName: AppRoutes.more,
      ),
    ];
  }

  List<GetRouterOutlet> get adminOutlates {
    final items = getVisibleItems();
    return items.map((route) {
      return GetRouterOutlet(initialRoute: route.routeName!, anchorRoute: '/');
    }).toList();
  }
}
