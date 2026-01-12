import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_rail/core/routes/app_pages.dart';
import 'package:food_rail/core/utils/responsive_layout.dart';
import 'package:food_rail/shared/widgets/custom_button.dart';
import 'package:food_rail/shared/widgets/custom_text.dart';
import 'package:food_rail/features/admin/restaurant/presentation/controllers/restaurant_controller.dart';

class RestaurantsPage extends GetView<RestaurantController> {
  const RestaurantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, screenInfo) {
          return Obx(() {
            if (controller.restaurants.isEmpty) {
              return const Center(child: CustomText('No Restaurants Found'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: controller.restaurants.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final restaurant = controller.restaurants[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  tileColor: Colors.grey.withValues(alpha: 0.05),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      restaurant.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  title: CustomText(
                    restaurant.name,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        restaurant.description,
                        color: Colors.grey[600],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: CustomText(
                              restaurant.address,
                              color: Colors.grey[600],
                              fontSize: 12,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          CustomText(
                            restaurant.rating.toString(),
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      CustomButton(
                        layout: ButtonLayout.iconOnly,
                        type: ButtonType.text,
                        icon: Icons.edit,
                        iconColor: Colors.blue,
                        onPressed: () => Get.toNamed(
                          AppRoutes.updateRestaurant,
                          parameters: {'id': restaurant.id},
                        ),
                      ),
                      CustomButton(
                        layout: ButtonLayout.iconOnly,
                        type: ButtonType.text,
                        icon: Icons.delete,
                        iconColor: Colors.red,
                        onPressed: () =>
                            controller.deleteRestaurant(restaurant.id),
                      ),
                    ],
                  ),
                );
              },
            );
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.clearControllers();
          Get.toNamed(AppRoutes.addRestaurant);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
