import 'package:get/get.dart';
import 'package:food_rail/features/admin/products/presentation/controllers/products_controller.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductsController(), permanent: true);
  }
}
