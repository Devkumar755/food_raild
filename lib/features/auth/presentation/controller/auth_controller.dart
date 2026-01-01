 import 'package:food_rail/core/base/base_controller.dart';
import 'package:get/get.dart';

class AuthController extends BaseController{


  final RxBool _isAdmin = false.obs;


  bool get isAdmin =>  _isAdmin.value;

  void changeIsAdmin(bool value){
    _isAdmin.value = value;
  }
 }