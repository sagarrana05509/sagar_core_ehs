import 'package:get/get.dart';
import 'package:sagar_core_ehs_demo/local_storage/user_local_storage_repository.dart';
import 'package:sagar_core_ehs_demo/models/user_profile_model.dart';
import 'package:sagar_core_ehs_demo/shared/repository.dart';

class DependencyInjection {
  static var isBusinessMode = false.obs;
  static var showLoader = true.obs;
  static var isConnected = true.obs;
  static var isAppOpened = false.obs;
  UserLocalStorageRepository userLocalStorageRepository =
      UserLocalStorageRepository();
  UserRepository userRepository = UserRepository();

  fetchData() async {
    List<UserProfile> list = await userLocalStorageRepository
        .getUnsyncedUsers();
    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        list[i].isSync = 1;
        await userRepository.saveUserProfile(list[i]);
      }
      await userLocalStorageRepository.markAllUsersAsSynced();
    }
  }
}
