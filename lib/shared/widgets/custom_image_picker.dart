import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_rail/core/utils/app_strings.dart';
import 'package:food_rail/shared/widgets/custom_text.dart';

class CustomImagePicker extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;
  final String label;

  const CustomImagePicker({
    super.key,
    required this.imagePath,
    required this.onPickImage,
    required this.onRemoveImage,
    this.label = AppStrings.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(label, fontWeight: FontWeight.bold, fontSize: 16),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onPickImage,
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[400]!),
            ),
            child: imagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: kIsWeb
                        ? Image.network(imagePath!, fit: BoxFit.contain)
                        : Image.file(File(imagePath!), fit: BoxFit.contain),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add_photo_alternate,
                        size: 50,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      CustomText(AppStrings.gallery, color: Colors.grey),
                    ],
                  ),
          ),
        ),
        if (imagePath != null)
          TextButton.icon(
            onPressed: onRemoveImage,
            icon: const Icon(Icons.delete, color: Colors.red),
            label: const CustomText(AppStrings.removeImage, color: Colors.red),
          ),
      ],
    );
  }
}
