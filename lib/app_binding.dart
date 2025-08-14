import 'package:get/get.dart';
import 'network/network_manger.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {

    Get.put(NetworkManager(), permanent: true);
  }
}
