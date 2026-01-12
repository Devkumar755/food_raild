import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_rail/features/admin/category/data/models/category_model.dart';

class CategoryController extends GetxController {
  var categories = <CategoryModel>[].obs;

  // Text Editing Controllers for Add/Update
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlController =
      TextEditingController(); // Keeping for backward compatibility if needed, or url input

  final Rx<XFile?> selectedImage = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() {
    // Mock Data
    categories.assignAll([
      CategoryModel(
        id: '1',
        name: 'Burgers',
        description: 'Juicy burgers',
        imageUrl: 'https://via.placeholder.com/150',
      ),
      CategoryModel(
        id: '2',
        name: 'Pizza',
        description: 'Cheesy pizzas',
        imageUrl: 'https://via.placeholder.com/150',
      ),
      CategoryModel(
        id: '3',
        name: 'Drinks',
        description: 'Cold beverages',
        imageUrl: 'https://via.placeholder.com/150',
      ),
    ]);
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = image;
    }
  }

  void removeImage() {
    selectedImage.value = null;
  }

  void addCategory() {
    if (titleController.text.isEmpty) {
      Get.snackbar("Error", "Title cannot be empty");
      return;
    }

    final newCategory = CategoryModel(
      id: DateTime.now().toString(),
      name: titleController.text,
      description: descriptionController.text,
      imageUrl:
          selectedImage.value?.path ??
          (imageUrlController.text.isNotEmpty
              ? imageUrlController.text
              : 'https://via.placeholder.com/150'),
    );

    categories.add(newCategory);
    clearControllers();
    Get.back(); // Go back after adding
    Get.snackbar('Success', 'Category added successfully');
  }

  void updateCategory(String id) {
    if (titleController.text.isEmpty) return;

    final index = categories.indexWhere((c) => c.id == id);
    if (index != -1) {
      categories[index] = CategoryModel(
        id: id,
        name: titleController.text,
        description: descriptionController.text,
        imageUrl: imageUrlController.text.isNotEmpty
            ? imageUrlController.text
            : 'https://via.placeholder.com/150',
      );
      categories.refresh(); // Force update if needed
      clearControllers();
      Get.back();
      Get.snackbar('Success', 'Category updated successfully');
    }
  }

  void deleteCategory(String id) {
    categories.removeWhere((c) => c.id == id);
    Get.snackbar('Deleted', 'Category removed');
  }

  void setForUpdate(CategoryModel category) {
    titleController.text = category.name;
    descriptionController.text = category.description;
    imageUrlController.text = category.imageUrl;
  }

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
    imageUrlController.clear();
  }
}
