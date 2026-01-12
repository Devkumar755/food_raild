import 'package:get/get.dart';
import 'package:food_rail/features/admin/category/presentation/controllers/category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(() => CategoryController(),fenix: true);
  }
}
