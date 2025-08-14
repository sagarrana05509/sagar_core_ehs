import 'package:get/get.dart';
import 'package:sagar_core_ehs_demo/modules/home/home_binding.dart';
import 'package:sagar_core_ehs_demo/modules/home/home_screen.dart';
import 'package:sagar_core_ehs_demo/modules/user_details/user_details_binding.dart';
import 'package:sagar_core_ehs_demo/modules/user_details/user_details_screen.dart';
part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
      children: [],
    ),
    GetPage(
      name: Routes.USERDETAILS,
      page: () => UserDetailsScreen(),
      binding: UserDetailsBinding(),
      children: [],
    ),
  ];
  static List lst = [];
}
