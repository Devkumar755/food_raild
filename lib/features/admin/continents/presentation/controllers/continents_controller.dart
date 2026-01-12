import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:food_rail/features/admin/continents/data/models/continent_model.dart';

class ContinentsController extends GetxController {
  var continents = <ContinentModel>[].obs;

  // Text Editing Controllers for Add/Update
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlController = TextEditingController();

  final Rx<XFile?> selectedImage = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchContinents();
  }

  void fetchContinents() {
    // Mock Data
    continents.assignAll([
      ContinentModel(
        id: '1',
        name: 'Italian',
        description: 'Pasta, Pizza and more',
        imageUrl: 'https://via.placeholder.com/150',
      ),
      ContinentModel(
        id: '2',
        name: 'Indian',
        description: 'Spicy curries and breads',
        imageUrl: 'https://via.placeholder.com/150',
      ),
      ContinentModel(
        id: '3',
        name: 'Chinese',
        description: 'Noodles, rice and dumplings',
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

  void addContinent() {
    if (nameController.text.isEmpty) {
      Get.snackbar("Error", "Name cannot be empty");
      return;
    }

    final newContinent = ContinentModel(
      id: DateTime.now().toString(),
      name: nameController.text,
      description: descriptionController.text,
      imageUrl:
          selectedImage.value?.path ??
          (imageUrlController.text.isNotEmpty
              ? imageUrlController.text
              : 'https://via.placeholder.com/150'),
    );

    continents.add(newContinent);
    clearControllers();
    Get.back();
    Get.snackbar('Success', 'Continent added successfully');
  }

  void updateContinent(String id) {
    if (nameController.text.isEmpty) return;

    final index = continents.indexWhere((c) => c.id == id);
    if (index != -1) {
      continents[index] = ContinentModel(
        id: id,
        name: nameController.text,
        description: descriptionController.text,
        imageUrl:
            selectedImage.value?.path ??
            (imageUrlController.text.isNotEmpty
                ? imageUrlController.text
                : 'https://via.placeholder.com/150'),
      );
      continents.refresh();
      clearControllers();
      Get.back();
      Get.snackbar('Success', 'Continent updated successfully');
    }
  }

  void deleteContinent(String id) {
    continents.removeWhere((c) => c.id == id);
    Get.snackbar('Deleted', 'Continent removed');
  }

  void setForUpdate(ContinentModel continent) {
    nameController.text = continent.name;
    descriptionController.text = continent.description;
    imageUrlController.text = continent.imageUrl;
    selectedImage.value = null; // Reset image picker
  }

  void clearControllers() {
    nameController.clear();
    descriptionController.clear();
    imageUrlController.clear();
    selectedImage.value = null;
  }
}
