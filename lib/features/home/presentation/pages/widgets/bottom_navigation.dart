  import 'package:flutter/material.dart';
import 'package:food_rail/features/home/presentation/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../../../../shared/widgets/custom_text.dart';

class CustomBottomNavigation extends StatelessWidget {
   final HomeController controller;
    const CustomBottomNavigation({super.key, required this.controller});

    @override
    Widget build(BuildContext context) {
      return    Obx(
            () {
          // A custom navigation bar container
          if(controller.getBottomNavigationItem().isEmpty){
            return SizedBox.shrink();
          }
          return Container(
            padding: const EdgeInsets.only(

                bottom: 10),
            height:80,
            // ResponsiveUtils.getResponsiveSpacing(context, 90),

            decoration: BoxDecoration(
              color:Theme.of(context).colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                controller.getBottomNavigationItem().length,
                    (index) {

                  final destination =
                  controller.getBottomNavigationItem()[index];
                  final isSelected = controller.currentIndex == index;

                  return Expanded(
                    child: InkWell(
                      onTap: () => controller.changeIndex(index),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),

                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            height: 3,
                            width: isSelected
                                ? 28
                                : 0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          SizedBox(height: 2,),
                          Icon(
                            (() {
                              final candidate = isSelected
                                  ? (destination.activeIcon ??
                                  destination.inactiveIcon)
                                  : destination.inactiveIcon;
                              if (candidate is IconData) return candidate;
                              return null;
                            })(),
                            color: isSelected ?Theme.of(context).colorScheme.primary : Colors.grey[600],
                            size: isSelected
                                ? 26
                                : 24,
                          ),

                          const SizedBox(height: 4),

                          CustomText(
                            destination.labelName.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey[600], // Match icon color
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );

        },
      );
    }
  }
