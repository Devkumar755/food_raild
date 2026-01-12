import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:food_rail/features/admin/restaurant/data/models/restaurant_model.dart';

class RestaurantController extends GetxController {
  var restaurants = <RestaurantModel>[].obs;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlController = TextEditingController();
  final addressController = TextEditingController();
  // final ratingController = TextEditingController(); // Removed

  final RxDouble rating = 0.0.obs;

  final Rx<XFile?> selectedImage = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchRestaurants();
  }

  void fetchRestaurants() {
    // Mock Data
    restaurants.assignAll([
      RestaurantModel(
        id: '1',
        name: 'The Italian Place',
        description: 'Authentic Italian Cuisine',
        imageUrl: 'https://via.placeholder.com/150',
        address: '123 Main St, New York',
        rating: 4.5,
      ),
      RestaurantModel(
        id: '2',
        name: 'Spice Garden',
        description: 'Best Indian Curries',
        imageUrl: 'https://via.placeholder.com/150',
        address: '456 Curry Lane, London',
        rating: 4.8,
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

  void setRating(double value) {
    rating.value = value;
  }

  void addRestaurant() {
    if (nameController.text.isEmpty) {
      Get.snackbar("Error", "Name cannot be empty");
      return;
    }

    final newRestaurant = RestaurantModel(
      id: DateTime.now().toString(),
      name: nameController.text,
      description: descriptionController.text,
      imageUrl:
          selectedImage.value?.path ??
          (imageUrlController.text.isNotEmpty
              ? imageUrlController.text
              : 'https://via.placeholder.com/150'),
      address: addressController.text,
      rating: rating.value,
    );

    restaurants.add(newRestaurant);
    clearControllers();
    Get.back();
    Get.snackbar('Success', 'Restaurant added successfully');
  }

  void updateRestaurant(String id) {
    if (nameController.text.isEmpty) return;

    final index = restaurants.indexWhere((r) => r.id == id);
    if (index != -1) {
      restaurants[index] = RestaurantModel(
        id: id,
        name: nameController.text,
        description: descriptionController.text,
        imageUrl:
            selectedImage.value?.path ??
            (imageUrlController.text.isNotEmpty
                ? imageUrlController.text
                : 'https://via.placeholder.com/150'),
        address: addressController.text,
        rating: rating.value,
      );
      restaurants.refresh();
      clearControllers();
      Get.back();
      Get.snackbar('Success', 'Restaurant updated successfully');
    }
  }

  void deleteRestaurant(String id) {
    restaurants.removeWhere((r) => r.id == id);
    Get.snackbar('Deleted', 'Restaurant removed');
  }

  void setForUpdate(RestaurantModel restaurant) {
    nameController.text = restaurant.name;
    descriptionController.text = restaurant.description;
    imageUrlController.text = restaurant.imageUrl;
    addressController.text = restaurant.address;
    rating.value = restaurant.rating;
    selectedImage.value = null;
  }

  void clearControllers() {
    nameController.clear();
    descriptionController.clear();
    imageUrlController.clear();
    addressController.clear();
    rating.value = 0.0;
    selectedImage.value = null;
  }
}
