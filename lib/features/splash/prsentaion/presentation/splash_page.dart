 import 'package:flutter/material.dart';
import 'package:food_rail/core/resources/app_colors.dart';
import 'package:food_rail/core/utils/app_images.dart';
import 'package:food_rail/core/utils/app_strings.dart';
import 'package:food_rail/shared/widgets/custom_text.dart';

import '../../../../core/utils/diamensions_file.dart';

class SplashPage extends StatelessWidget {
  const SplashPage
({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(
        margin: EdgeInsets.symmetric(horizontal: Diamensions.globalHorizontalPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Image.asset(
                  AppImages.imageLogo
                ),
              ),
              CustomText(
               AppStrings.appName,
               style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor
               ),
              ),
                CustomText(
               AppStrings.sloganText,
                  style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryFontColor
               ),
              ),
              ],
          ),
        ),
      ))
    );
  }
}