import 'package:flutter/material.dart';
import 'package:food_rail/core/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:food_rail/features/admin/products/presentation/controllers/products_controller.dart';
import 'package:food_rail/shared/widgets/custom_button.dart';

class ProductsPage extends GetView<ProductsController> {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Products",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.products.isEmpty) {
                  return const Center(child: Text("No products found"));
                }
                return ListView.separated(
                  itemCount: controller.products.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final product = controller.products[index];
                    return ListTile(
                      leading: product.bannerImage.isNotEmpty
                          ? Image.network(
                              product.bannerImage,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.error),
                            )
                          : const Icon(Icons.image, size: 50),
                      title: Text(product.title),
                      subtitle: Text(
                        "Price: \$${product.sellPrice} | Qty: ${product.quantity}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomButton(
                            layout: ButtonLayout.iconOnly,
                            type: ButtonType.text,
                            icon: Icons.edit,
                            iconColor: Colors.blue,
                            onPressed: () {}, // Implement Edit
                          ),
                          CustomButton(
                            layout: ButtonLayout.iconOnly,
                            type: ButtonType.text,
                            icon: Icons.delete,
                            iconColor: Colors.red,
                            onPressed: () =>
                                controller.deleteProduct(product.id),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.clearControllers();
          Get.toNamed(AppRoutes.addProducts);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
