import 'package:food_rail/features/splash/prsentaion/presentation/splash_page.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static  List<GetPage> getAppPages = [
    GetPage(name: AppRoutes.splash,
    page: () => SplashPage()
    
  ),
  ];
}
