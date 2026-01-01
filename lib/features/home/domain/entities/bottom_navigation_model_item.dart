

import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../../core/resources/app_colors.dart';

class BottomNavigationModelItem {
  String? routeName;
  String? labelName;
  String?  routeId;
  IconData? activeIcon;
  IconData? inactiveIcon;

   BottomNavigationModelItem({this.activeIcon,this.inactiveIcon,this.routeId,this.routeName,this.labelName});


  SidebarXItem toSidebarXItem(VoidCallback onTap) {
    return SidebarXItem(
      iconBuilder: (isSelected, isExtended) {
        return Icon(
          isSelected ? activeIcon: inactiveIcon,
          color: isSelected ? AppColors.primaryColor : AppColors.primaryFontColor,
        );
      },
      label: labelName,
      onTap: onTap,
    );
  }
 }