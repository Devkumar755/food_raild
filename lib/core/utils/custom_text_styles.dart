

import 'package:flutter/material.dart';
import 'package:food_rail/core/resources/app_colors.dart';

class CustomTextStyles {
   static TextStyle? getLonginTitle(){
      return TextStyle(
        color: AppColors.primaryFontColor,
        fontWeight: FontWeight.bold,
        fontSize: 26
      );
    }


   static TextStyle? getLonginDescription({Color? color}){
     return TextStyle(
         color: color ??  AppColors.secondaryFontColor,
         fontSize: 17,
       fontWeight: FontWeight.w600
     );
   }

  }