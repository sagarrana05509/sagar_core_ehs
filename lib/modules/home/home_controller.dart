import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sagar_core_ehs_demo/di.dart';
import 'package:sagar_core_ehs_demo/local_storage/user_local_storage_repository.dart';
import 'package:sagar_core_ehs_demo/models/user_profile_model.dart';
import 'package:sagar_core_ehs_demo/shared/repository.dart';
import 'package:sagar_core_ehs_demo/shared/constants/string_constant.dart';

class HomeController extends GetxController {
  RxList<UserProfile> userList = <UserProfile>[].obs;
  UserRepository userRepository = UserRepository();
  UserLocalStorageRepository userLocalStorageRepository =
      UserLocalStorageRepository();
  TextEditingController searchController = TextEditingController();
  var minValue = 18.0.obs;
  var maxValue = 60.0.obs;

  RxBool isAscending = true.obs;
  RxBool syncData = false.obs;
  RxBool notSyncData = false.obs;

  @override
  void onInit() async {
    EasyLoading.show(status: StringConstant.loading);
    await getData();
    EasyLoading.dismiss();
    super.onInit();
  }

  getData() async {
    if (DependencyInjection.isConnected.value) {
      userList.value = await userRepository.getAllUsers();
      userLocalStorageRepository.replaceUserProfiles(userList);
    } else {
      userList.value = await userLocalStorageRepository.getAllUsers();
    }
  }

  fetchData() async {
    if (DependencyInjection.isConnected.value) {
      List<UserProfile> list = await userLocalStorageRepository
          .getUnsyncedUsers();
      if (list.isNotEmpty) {
        for (int i = 0; i < list.length; i++) {
          list[i].isSync = 1;
          await userRepository.saveUserProfile(list[i]);
        }
        await userLocalStorageRepository.markAllUsersAsSynced();
        Get.snackbar(
          StringConstant.success,
          StringConstant.dataSyncSuccess,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          StringConstant.noData,
          StringConstant.noDataToSync,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        StringConstant.error,
        StringConstant.internetConnectivityNotAvailable,
      );
    }
  }

  onChange(String value) async {
    if (value.isEmpty) {
      userList.value = await userLocalStorageRepository.getAllUsers();
    } else {
      userList.value = await userLocalStorageRepository.searchUsers(value);
    }
  }

  ascendingDescendingData() async {
    isAscending.value = !isAscending.value;
    userList.value = await userLocalStorageRepository.getUsersSortedByName(
      ascending: isAscending.value,
    );
  }

  void setRange(double min, double max) async {
    minValue.value = min;
    maxValue.value = max;
  }

  getRangeData() async {
    userList.value = await userLocalStorageRepository.getUsersGroupedBySync(
      minValue.value.toInt(),
      maxValue.value.toInt(),
      notSyncData.value,
      syncData.value,
    );
  }

  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = userList.removeAt(oldIndex);
    userList.insert(newIndex, item);
  }
}
