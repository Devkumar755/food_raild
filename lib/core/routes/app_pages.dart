import 'package:food_rail/features/admin/dashbaord/prsentation/admin_dashboard.dart';
import 'package:food_rail/features/admin/dashbaord/prsentation/binding/admin_dash_binding.dart';
import 'package:food_rail/features/auth/presentation/binding/login_binding.dart';
import 'package:food_rail/features/auth/presentation/pages/forgot_password.dart';
import 'package:food_rail/features/auth/presentation/pages/login_page.dart';
import 'package:food_rail/features/auth/presentation/pages/register_page.dart';
import 'package:food_rail/features/home/presentation/binding/home_binding.dart';
import 'package:food_rail/features/home/presentation/pages/dash_board_page.dart';
import 'package:food_rail/features/home/presentation/pages/home_page.dart';
import 'package:food_rail/features/home/presentation/pages/menu_page.dart';
import 'package:food_rail/features/more/more_page.dart';
import 'package:food_rail/features/offers/offer_page.dart';
import 'package:food_rail/features/profile/profile_page.dart';
import 'package:food_rail/features/splash/prsentaion/presentation/splash_page.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static  List<GetPage> getAppPages = [
    GetPage(name: AppRoutes.splash,
    page: () => SplashPage()
    ),
    GetPage(name: AppRoutes.home,
        page: () => HomePage(),
      binding: HomeBinding()
    ),
    GetPage(name: AppRoutes.menu,
        page: () => MenuPage(),
    ),
    GetPage(name: AppRoutes.profile,
        page: () => ProfilePage(),
    ),
    GetPage(name: AppRoutes.more,
        page: () => MorePage(),
    ),
    GetPage(name: AppRoutes.offers,
        page: () => OfferPage(),
    ),
    GetPage(name: AppRoutes.dashboard,
      page: () => DashBoardPage(),
    ),

    GetPage(name: AppRoutes.login,
      page: () => LoginPage(),
      binding: LoginBinding()
    ),
    GetPage(name: AppRoutes.signUp,
        page: () => RegisterPage(),
    ),
    GetPage(name: AppRoutes.forgotPassword,
      page: () => ForgotPassword(),
    ),
    GetPage(name: AppRoutes.adminDashBoard,
      page: () => AdminDashboard(),
      binding: AdminDashBinding()
    ),
  ];
}
