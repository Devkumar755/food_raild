 import 'package:food_rail/features/admin/dashbaord/prsentation/controllers/admin_dash_controller.dart';
import 'package:get/get.dart';

class AdminDashBinding  extends Bindings {
  @override
  void dependencies() {
     Get.put(AdminDashController(), permanent: true);
  }
}