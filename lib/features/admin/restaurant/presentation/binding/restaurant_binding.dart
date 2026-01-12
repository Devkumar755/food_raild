import 'package:get/get.dart';
import 'package:food_rail/features/admin/restaurant/presentation/controllers/restaurant_controller.dart';

class RestaurantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestaurantController>(() => RestaurantController());
  }
}
