import 'package:get/get.dart';
import 'package:sagar_core_ehs_demo/modules/user_details/user_details_controller.dart';

class UserDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDetailsController>(() => UserDetailsController());
  }
}
