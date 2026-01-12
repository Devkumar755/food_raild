import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_rail/core/utils/responsive_layout.dart';
import 'package:food_rail/shared/widgets/custom_button.dart';
import 'package:food_rail/shared/widgets/custom_image_picker.dart';
import 'package:food_rail/shared/widgets/custom_text_field.dart';
import 'package:food_rail/features/admin/continents/presentation/controllers/continents_controller.dart';

class UpdateContinentPage extends GetView<ContinentsController> {
  final String continentId;
  const UpdateContinentPage({super.key, required this.continentId});

  @override
  Widget build(BuildContext context) {
    final continent = controller.continents.firstWhereOrNull(
      (c) => c.id == continentId,
    );
    if (continent != null) {
      controller.setForUpdate(continent);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Update Continent")),
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
                        onPressed: () =>
                            controller.updateContinent(continentId),
                        text: "Update",
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
          hintText: "Enter Continent Name",
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
          maxLines: 5,
          height: 120,
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
      final displayPath =
          image?.path ??
          (controller.imageUrlController.text.isNotEmpty
              ? controller.imageUrlController.text
              : null);

      return CustomImagePicker(
        imagePath: displayPath,
        onPickImage: controller.pickImage,
        onRemoveImage: controller.removeImage,
      );
    });
  }
}
