import 'package:get/get.dart';
import 'package:food_rail/features/admin/continents/presentation/controllers/continents_controller.dart';

class ContinentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContinentsController>(() => ContinentsController());
  }
}
