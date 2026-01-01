

import 'package:flutter/material.dart';
import 'package:food_rail/core/resources/app_colors.dart';
import 'package:food_rail/core/routes/app_pages.dart';
import 'package:food_rail/core/utils/app_images.dart';
import 'package:food_rail/core/utils/app_strings.dart';
import 'package:food_rail/shared/widgets/custom_text.dart';
import 'package:food_rail/shared/widgets/fixed_logo.dart';
import 'package:get/get.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scale = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    _controller.addStatusListener((status){
      if(status == AnimationStatus.completed){
        Get.toNamed(AppRoutes.adminDashBoard);
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Center(
            child: FadeTransition(
              opacity: _fade,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _scale,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: FixedLogo(),
                    ),
                  ),

                  const SizedBox(height: 32),

                  SlideTransition(
                    position: _slide,
                    child: Column(
                      children: [
                        CustomText(
                          AppStrings.appName,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomText(
                          AppStrings.sloganText,
                    
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.secondaryFontColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 48),

                  const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
