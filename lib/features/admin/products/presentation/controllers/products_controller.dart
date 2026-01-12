import 'package:flutter/material.dart';
import 'package:food_rail/core/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:food_rail/features/admin/category/data/models/category_model.dart';
import 'package:food_rail/features/admin/continents/data/models/continent_model.dart';
import 'package:food_rail/features/admin/restaurant/data/models/restaurant_model.dart';
import 'package:food_rail/features/admin/products/data/models/product_model.dart';

class ProductsController extends BaseController {
  var products = <ProductModel>[].obs;

  // Dropdown Data
  var categories = <CategoryModel>[].obs;
  var continents = <ContinentModel>[].obs;
  var restaurants = <RestaurantModel>[].obs;

  // Selected Items
  final Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
  final Rx<ContinentModel?> selectedContinent = Rx<ContinentModel?>(null);
  final Rx<RestaurantModel?> selectedRestaurant = Rx<RestaurantModel?>(null);

  // Form Controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final mrpController = TextEditingController();
  final sellPriceController = TextEditingController();
  final costPriceController = TextEditingController();
  final quantityController = TextEditingController();
  final minQtyController = TextEditingController();

  // Images
  final Rx<XFile?> bannerImage = Rx<XFile?>(null);
  final RxList<XFile> productImages = <XFile>[].obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
  }

  void fetchInitialData() {
    // Mock Data Fetching
    fetchProducts();
    fetchCategories();
    fetchContinents();
    fetchRestaurants();
  }

  void fetchProducts() {
    // Mock Products
    products.assignAll([]);
  }

  void fetchCategories() {
    // Mock: Should call repository or service
    categories.assignAll([
      CategoryModel(id: '1', name: 'Burgers', description: '', imageUrl: ''),
      CategoryModel(id: '2', name: 'Pizza', description: '', imageUrl: ''),
      CategoryModel(id: '3', name: 'Drinks', description: '', imageUrl: ''),
    ]);
  }

  void fetchContinents() {
    continents.assignAll([
      ContinentModel(id: '1', name: 'Italian', description: '', imageUrl: ''),
      ContinentModel(id: '2', name: 'Indian', description: '', imageUrl: ''),
    ]);
  }

  void fetchRestaurants() {
    restaurants.assignAll([
      RestaurantModel(
        id: '1',
        name: 'The Italian Place',
        description: '',
        imageUrl: '',
        address: '',
        rating: 4.5,
      ),
      RestaurantModel(
        id: '2',
        name: 'Spice Garden',
        description: '',
        imageUrl: '',
        address: '',
        rating: 4.8,
      ),
    ]);
  }

  Future<void> pickBannerImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      bannerImage.value = image;
    }
  }

  Future<void> pickProductImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      productImages.addAll(images);
    }
  }

  void removeProductImage(int index) {
    productImages.removeAt(index);
  }

  void addProduct() {
    if (titleController.text.isEmpty ||
        selectedCategory.value == null ||
        selectedContinent.value == null ||
        selectedRestaurant.value == null) {
      Get.snackbar("Error", "Please fill essential details");
      return;
    }

    // Logic to upload images and create product object...
    final newProduct = ProductModel(
      id: DateTime.now().toString(),
      title: titleController.text,
      description: descriptionController.text,
      price: double.tryParse(priceController.text) ?? 0,
      mrp: double.tryParse(mrpController.text) ?? 0,
      sellPrice: double.tryParse(sellPriceController.text) ?? 0,
      costPrice: double.tryParse(costPriceController.text) ?? 0,
      quantity: int.tryParse(quantityController.text) ?? 0,
      minQty: int.tryParse(minQtyController.text) ?? 0,
      bannerImage: bannerImage.value?.path ?? '',
      productImages: productImages.map((e) => e.path).toList(),
      categoryId: selectedCategory.value!.id,
      continentId: selectedContinent.value!.id,
      restaurantId: selectedRestaurant.value!.id,
    );

    products.add(newProduct);
    clearControllers();
    Get.back();
    Get.snackbar("Success", "Product Added");
  }

  void updateProduct(String id) {
    // Similar update logic
    Get.back();
    Get.snackbar("Success", "Product Updated");
  }

  void deleteProduct(String id) {
    products.removeWhere((p) => p.id == id);
    Get.snackbar("Deleted", "Product deleted");
  }

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
    priceController.clear();
    mrpController.clear();
    sellPriceController.clear();
    costPriceController.clear();
    quantityController.clear();
    minQtyController.clear();
    bannerImage.value = null;
    productImages.clear();
    selectedCategory.value = null;
    selectedContinent.value = null;
    selectedRestaurant.value = null;
  }
}
