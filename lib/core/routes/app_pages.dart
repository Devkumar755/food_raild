import 'package:food_rail/features/admin/category/presentation/binding/category_binding.dart';
import 'package:food_rail/features/admin/category/presentation/pages/add_category_page.dart';
import 'package:food_rail/features/admin/category/presentation/pages/update_category_page.dart';
import 'package:food_rail/features/admin/category/presentation/pages/categries_pages.dart';
import 'package:food_rail/features/admin/continents/presentation/binding/continents_binding.dart';
import 'package:food_rail/features/admin/continents/presentation/pages/add_continent_page.dart';
import 'package:food_rail/features/admin/continents/presentation/pages/conintents_pages.dart';
import 'package:food_rail/features/admin/continents/presentation/pages/update_continent_page.dart';
import 'package:food_rail/features/admin/dashbaord/prsentation/admin_dashboard.dart';
import 'package:food_rail/features/admin/dashbaord/prsentation/binding/admin_dash_binding.dart';
import 'package:food_rail/features/admin/products/presentation/binding/products_binding.dart';
import 'package:food_rail/features/admin/products/presentation/pages/add_product_page.dart';
import 'package:food_rail/features/admin/products/presentation/pages/products_page.dart';
import 'package:food_rail/features/admin/products/presentation/pages/update_product_page.dart';
import 'package:food_rail/features/admin/restaurant/presentation/binding/restaurant_binding.dart';

import 'package:food_rail/features/admin/restaurant/presentation/pages/add_restaurant_page.dart';
import 'package:food_rail/features/admin/restaurant/presentation/pages/restaurants_page.dart';
import 'package:food_rail/features/admin/restaurant/presentation/pages/update_restaurant_page.dart';
import 'package:food_rail/features/admin/products/presentation/pages/products_page.dart';
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

  static List<GetPage> getAppPages = [
    GetPage(name: AppRoutes.splash, page: () => SplashPage()),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(name: AppRoutes.menu, page: () => MenuPage()),
    GetPage(name: AppRoutes.profile, page: () => ProfilePage()),
    GetPage(name: AppRoutes.more, page: () => MorePage()),
    GetPage(name: AppRoutes.offers, page: () => OfferPage()),
    GetPage(name: AppRoutes.dashboard, page: () => DashBoardPage()),

    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(name: AppRoutes.signUp, page: () => RegisterPage()),
    GetPage(name: AppRoutes.forgotPassword, page: () => ForgotPassword()),
    GetPage(
      name: AppRoutes.adminDashBoard,
      page: () => AdminDashboard(),
      binding: AdminDashBinding(),
    ),
    GetPage(name: AppRoutes.productList, page: () => ProductsPage()),
    GetPage(
      name: AppRoutes.categoriesPage,
      page: () => CategoriesPages(),
      binding: CategoryBinding(),
    ),
    GetPage(name: AppRoutes.addCategory, page: () => AddCategoryPage()),
    GetPage(
      name: AppRoutes.updateCategory,
      page: () {
        final args = Get.parameters;
        return UpdateCategoryPage(categoryId: args['id'] ?? '');
      },
    ),
    GetPage(
      name: AppRoutes.continentsPage,
      page: () => ContinentsPages(),
      binding: ContinentsBinding(),
    ),
    GetPage(name: AppRoutes.addContinents, page: () => AddContinentPage()),
    GetPage(
      name: AppRoutes.updateContinents,
      page: () {
        final args = Get.parameters;
        return UpdateContinentPage(continentId: args['id'] ?? '');
      },
    ),
    GetPage(
      name: AppRoutes.restaurantList,
      page: () => RestaurantsPage(),
      binding: RestaurantBinding(),
    ),
    GetPage(name: AppRoutes.addRestaurant, page: () => AddRestaurantPage()),
    GetPage(
      name: AppRoutes.updateRestaurant,
      page: () {
        final args = Get.parameters;
        return UpdateRestaurantPage(restaurantId: args['id'] ?? '');
      },
    ),
    GetPage(
      name: AppRoutes.productList,
      page: () => ProductsPage(),
      binding: ProductsBinding(),
    ),
    GetPage(name: AppRoutes.addProducts, page: () => AddProductPage()),
    GetPage(name: AppRoutes.updateProducts, page: () => UpdateProductPage()),
  ];
}
