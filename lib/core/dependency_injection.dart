import 'package:food_rail/features/admin/products/presentation/controllers/products_controller.dart';
import 'package:get/get.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductsController(), permanent: true);
  }
}
