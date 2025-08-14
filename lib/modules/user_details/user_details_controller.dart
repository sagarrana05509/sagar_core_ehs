import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sagar_core_ehs_demo/di.dart';
import 'package:sagar_core_ehs_demo/local_storage/user_local_storage_repository.dart';
import 'package:sagar_core_ehs_demo/models/user_profile_model.dart';
import 'package:sagar_core_ehs_demo/modules/home/home_controller.dart';
import 'package:sagar_core_ehs_demo/shared/constants/string_constant.dart';
import 'package:sagar_core_ehs_demo/shared/repository.dart';

class UserDetailsController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController searchText = TextEditingController();
  UserRepository userRepository = UserRepository();
  final formKey = GlobalKey<FormState>(); // form key

  RxString gender = "Male".obs;
  final localRepo = UserLocalStorageRepository();
  RxList<String> games = const [
    'Cricket',
    'Football',
    'Badminton',
    'Chess',
    'Carrom',
    'Table Tennis',
    'Volleyball',
    'Basketball',
    'Hockey',
    'Esports',
  ].obs;
  RxList<String> books = const [
    '1984',
    'The Alchemist',
    'Atomic Habits',
    'The Pragmatic Programmer',
    'Clean Code',
    'Sapiens',
    'Deep Work',
    'Harry Potter',
    'The Hobbit',
    'Mahabharata',
  ].obs;
  RxList<String> cities = const [
    'Mumbai',
    'Delhi',
    'Bengaluru',
    'Hyderabad',
    'Ahmedabad',
    'Pune',
    'Kolkata',
    'Chennai',
    'Jaipur',
    'Surat',
    'New York',
    'London',
    'Tokyo',
    'Paris',
    'Dubai',
  ].obs;

  final selectedGames = <String>[].obs;
  final selectedBooks = <String>[].obs;
  final selectedCities = <String>[].obs;

  submitData() async {
    if (formKey.currentState!.validate()) {
      if (selectedGames.isEmpty) {
        Get.snackbar(
          StringConstant.error,
          StringConstant.selectGames,
          colorText: Colors.red,
        );
      } else if (selectedCities.isEmpty) {
        Get.snackbar(
          StringConstant.error,
          StringConstant.selectCities,
          colorText: Colors.red,
        );
      } else if (selectedBooks.isEmpty) {
        Get.snackbar(
          StringConstant.error,
          StringConstant.selectBooks,
          colorText: Colors.red,
        );
      } else {
        var homeController = Get.find<HomeController>();
        EasyLoading.show(status: StringConstant.loading);

        UserProfile userProfile = UserProfile(
          name: nameController.text,
          age: int.parse(ageController.text),
          gender: gender.value,
          selectedGames: selectedGames,
          visitedCities: selectedCities,
          selectedBooks: selectedBooks,
          isSync: 1,
        );
        if (DependencyInjection.isConnected.value) {
          await userRepository.saveUserProfile(userProfile);
          localRepo.insertUser(userProfile);
        } else {
          userProfile.isSync = 0;
          localRepo.insertUser(userProfile);
        }
        homeController.userList.add(userProfile);
        EasyLoading.dismiss();
        Get.back();
        Get.snackbar(StringConstant.success, StringConstant.dataInsertSuccess);
      }
    }
  }
}
