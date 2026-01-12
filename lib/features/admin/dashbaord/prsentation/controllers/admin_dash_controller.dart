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
        labelName: "Categories",
        routeId: AppRoutes.categoriesPage,
        routeName: AppRoutes.categoriesPage,
      ),
      BottomNavigationModelItem(
        labelName: "Continents",
        routeId: AppRoutes.continentsPage,
        routeName: AppRoutes.continentsPage,
      ),
      BottomNavigationModelItem(
        labelName: "Products",
        routeId: AppRoutes.productList,
        routeName: AppRoutes.productList,
      ),
      BottomNavigationModelItem(
        labelName: "Restaurants",
        routeId: AppRoutes.restaurantList,
        routeName: AppRoutes.restaurantList,
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
