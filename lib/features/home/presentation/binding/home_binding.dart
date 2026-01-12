import 'package:food_rail/features/admin/category/presentation/binding/category_binding.dart';
import 'package:food_rail/features/admin/category/presentation/controllers/category_controller.dart';
import 'package:food_rail/features/admin/products/presentation/binding/products_binding.dart';
import 'package:food_rail/features/admin/products/presentation/controllers/products_controller.dart';
import 'package:food_rail/features/home/presentation/controllers/home_controller.dart';
import 'package:get/instance_manager.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
    if (Get.isRegistered<CategoryController>() == false) {
      CategoryBinding().dependencies();
    }

    if (Get.isRegistered<ProductsController>() == false) {
      ProductsBinding().dependencies();
    }
  }
}
