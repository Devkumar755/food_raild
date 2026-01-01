  import 'package:food_rail/features/auth/presentation/controller/auth_controller.dart';
import 'package:get/get.dart';

class LoginBinding  extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut(() => AuthController());
  }

  }