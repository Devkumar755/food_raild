import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:food_rail/features/admin/products/presentation/controllers/products_controller.dart';
import 'package:food_rail/shared/widgets/custom_button.dart';
import 'package:food_rail/shared/widgets/custom_text_field.dart';
import 'package:food_rail/shared/widgets/custom_searchable_dropdown.dart';
import 'package:food_rail/core/utils/responsive_layout.dart';

class AddProductPage extends GetView<ProductsController> {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Product")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: ResponsiveLayout(
          mobile: _buildMobileLayout(context),
          desktop: _buildDesktopLayout(context),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildMediaSection(context),
        const SizedBox(height: 24),
        _buildBasicInfoSection(context),
        const SizedBox(height: 24),
        _buildDropdownSection(context),
        const SizedBox(height: 24),
        _buildPricingStockSection(context),
        const SizedBox(height: 32),
        CustomButton(
          text: "Add Product",
          onPressed: controller.addProduct,
          width: double.infinity,
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(children: [_buildMediaSection(context)]),
        ),
        const SizedBox(width: 32),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBasicInfoSection(context),
              const SizedBox(height: 24),
              _buildDropdownSection(context),
              const SizedBox(height: 24),
              _buildPricingStockSection(context),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerRight,
                child: CustomButton(
                  text: "Add Product",
                  onPressed: controller.addProduct,
                  width: 200,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMediaSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Banner Image",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Obx(() {
          final banner = controller.bannerImage.value;
          return GestureDetector(
            onTap: controller.pickBannerImage,
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                image: banner != null
                    ? DecorationImage(
                        image: FileImage(File(banner.path)),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: banner == null
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add_a_photo),
                          Text("Upload Banner"),
                        ],
                      ),
                    )
                  : null,
            ),
          );
        }),
        const SizedBox(height: 16),
        const Text(
          "Product Images",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Obx(
          () => Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...controller.productImages.map(
                (img) => Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: FileImage(File(img.path)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => controller.productImages.remove(img),
                        child: const Icon(Icons.cancel, color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: controller.pickProductImages,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBasicInfoSection(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: controller.titleController,
          labelText: "Product Title",
          hintText: "Enter product title",
          type: TextFieldType.name,
        ),
        const SizedBox(height: 16),
        CustomTextFormField(
          controller: controller.descriptionController,
          labelText: "Description",
          hintText: "Enter description",
          type: TextFieldType.name,
          maxLines: 4,
        ),
      ],
    );
  }

  Widget _buildDropdownSection(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          CustomSearchableDropdown(
            items: controller.categories,
            title: "Select Category",
            itemLabel: (item) => item.name,
            selectedItem: controller.selectedCategory.value,
            onChanged: (val) => controller.selectedCategory.value = val,
            hint: "Select Category",
          ),
          const SizedBox(height: 16),
          CustomSearchableDropdown(
            items: controller.continents,
            title: "Select Continent",
            itemLabel: (item) => item.name,
            selectedItem: controller.selectedContinent.value,
            onChanged: (val) => controller.selectedContinent.value = val,
            hint: "Select Continent",
          ),
          const SizedBox(height: 16),
          CustomSearchableDropdown(
            items: controller.restaurants,
            title: "Select Restaurant",
            itemLabel: (item) => item.name,
            selectedItem: controller.selectedRestaurant.value,
            onChanged: (val) => controller.selectedRestaurant.value = val,
            hint: "Select Restaurant",
          ),
        ],
      ),
    );
  }

  Widget _buildPricingStockSection(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: controller.priceController,
                labelText: "Price",
                hintText: "0.00",
                type: TextFieldType.name,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextFormField(
                controller: controller.mrpController,
                labelText: "MRP",
                hintText: "0.00",
                type: TextFieldType.name,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: controller.sellPriceController,
                labelText: "Sell Price",
                hintText: "0.00",
                type: TextFieldType.name,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextFormField(
                controller: controller.costPriceController,
                labelText: "Cost Price",
                hintText: "0.00",
                type: TextFieldType.name,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: controller.quantityController,
                labelText: "Quantity",
                hintText: "0",
                type: TextFieldType.name,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextFormField(
                controller: controller.minQtyController,
                labelText: "Min Qty",
                hintText: "0",
                type: TextFieldType.name,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
