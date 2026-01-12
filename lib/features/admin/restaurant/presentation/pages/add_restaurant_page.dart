import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_rail/core/utils/app_strings.dart';
import 'package:food_rail/core/utils/responsive_layout.dart';
import 'package:food_rail/shared/widgets/custom_button.dart';
import 'package:food_rail/shared/widgets/custom_image_picker.dart';
import 'package:food_rail/shared/widgets/custom_text_field.dart';
import 'package:food_rail/shared/widgets/star_rating_selector.dart';
import 'package:food_rail/features/admin/restaurant/presentation/controllers/restaurant_controller.dart';

class AddRestaurantPage extends GetView<RestaurantController> {
  const AddRestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Restaurant")),
      body: ResponsiveBuilder(
        builder: (context, screenInfo) {
          bool isDesktop = screenInfo.deviceType == DeviceType.desktop;

          return Center(
            child: SizedBox(
              width: isDesktop ? 800 : double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isDesktop)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildForm(context)),
                          const SizedBox(width: 30),
                          Expanded(child: _buildImagePicker(context)),
                        ],
                      )
                    else
                      Column(
                        children: [
                          _buildImagePicker(context),
                          const SizedBox(height: 20),
                          _buildForm(context),
                        ],
                      ),
                    const SizedBox(height: 30),
                    Center(
                      child: CustomButton(
                        width: isDesktop ? 200 : double.infinity,
                        height: 50,
                        onPressed: controller.addRestaurant,
                        text: AppStrings.save,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: controller.nameController,
          hintText: "Enter Restaurant Name",
          labelText: "Name",
          type: TextFieldType.name,
          isLabelRequired: true,
        ),
        const SizedBox(height: 16),
        CustomTextFormField(
          controller: controller.descriptionController,
          hintText: "Enter Description",
          labelText: "Description",
          type: TextFieldType.name,
          isLabelRequired: true,
          maxLines: 3,
          height: 80,
        ),
        const SizedBox(height: 16),
        CustomTextFormField(
          controller: controller.addressController,
          hintText: "Enter Address",
          labelText: "Address",
          type: TextFieldType.name,
          isLabelRequired: true,
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 16),
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Rating",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              StarRatingSelector(
                rating: controller.rating.value,
                onRatingChanged: controller.setRating,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        CustomTextFormField(
          controller: controller.imageUrlController,
          hintText: "Enter Image URL",
          labelText: "Image URL",
          type: TextFieldType.name,
          isLabelRequired: true,
        ),
      ],
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return Obx(() {
      final image = controller.selectedImage.value;
      return CustomImagePicker(
        imagePath: image?.path,
        onPickImage: controller.pickImage,
        onRemoveImage: controller.removeImage,
      );
    });
  }
}
