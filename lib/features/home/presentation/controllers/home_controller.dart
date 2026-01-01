 import 'package:flutter/material.dart';
import 'package:food_rail/core/base/base_controller.dart';
import 'package:food_rail/core/routes/app_pages.dart';
import 'package:food_rail/features/home/domain/entities/bottom_navigation_model_item.dart';
import 'package:get/get.dart';
import 'package:solar_icons/solar_icons.dart';

class HomeController extends BaseController {



  final RxInt _currentIndex = 2.obs;

  int get currentIndex => _currentIndex.value;

  void changeIndex(int index){
    _currentIndex.value = index;
    update();
  }

List<GetRouterOutlet> get bottomOutlates {
  final items = getBottomNavigationItem();
  return items.map((routes){
    return GetRouterOutlet(
        initialRoute: routes.routeName!,
      anchorRoute: '/',
    );
  }).toList();
}


  List<BottomNavigationModelItem> getBottomNavigationItem() {
    return [
      BottomNavigationModelItem(
        labelName: "Menu",
        routeId: AppRoutes.menu,
        inactiveIcon: SolarIconsOutline.widget_6,
        activeIcon: SolarIconsBold.widget_6,
        routeName: AppRoutes.menu
      ),
      BottomNavigationModelItem(
          labelName: "Offers",
          routeId: AppRoutes.offers,
          inactiveIcon: SolarIconsOutline.confetti,
          activeIcon: SolarIconsBold.confettiMinimalistic,
          routeName: AppRoutes.offers
      ),
      BottomNavigationModelItem(
          labelName: "Home",
          routeId: AppRoutes.dashboard,
          inactiveIcon: Icons.home_outlined,
          activeIcon: SolarIconsBold.home1,
          routeName: AppRoutes.dashboard
      ),
      BottomNavigationModelItem(
          labelName: "Profile",
          routeId: AppRoutes.profile,
          inactiveIcon: SolarIconsOutline.user,
          activeIcon: SolarIconsBold.user,
          routeName: AppRoutes.profile
      ),
      BottomNavigationModelItem(
          labelName: "More",
          routeId: AppRoutes.more,
          inactiveIcon: SolarIconsOutline.listDownMinimalistic,
          activeIcon: SolarIconsBold.listDownMinimalistic,
          routeName: AppRoutes.more
      ),
    ];
  }

 }