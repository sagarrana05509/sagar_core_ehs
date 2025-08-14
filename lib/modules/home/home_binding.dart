import 'package:get/get.dart';
import 'package:sagar_core_ehs_demo/modules/home/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(()=>HomeController());
  }
}