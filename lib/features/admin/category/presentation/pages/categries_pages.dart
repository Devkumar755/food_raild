import 'package:flutter/material.dart';
import 'package:food_rail/core/utils/responsive_layout.dart';
import 'package:food_rail/shared/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:food_rail/features/admin/category/presentation/controllers/category_controller.dart';
import 'package:food_rail/core/routes/app_pages.dart';

class CategoriesPages extends GetView<CategoryController> {
  const CategoriesPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, screenInfo) {
          return Obx(() {
            if (controller.categories.isEmpty) {
              return const Center(child: CustomText('No Categories Found'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: controller.categories.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final category = controller.categories[index];
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
                      category.imageUrl,
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
                    category.name,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  subtitle: CustomText(
                    category.description,
                    color: Colors.grey[600],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => Get.toNamed(
                          AppRoutes.updateCategory,
                          parameters: {'id': category.id},
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => controller.deleteCategory(category.id),
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
          Get.toNamed(AppRoutes.addCategory);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
