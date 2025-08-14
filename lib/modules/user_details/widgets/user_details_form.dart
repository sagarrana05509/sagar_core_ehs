import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sagar_core_ehs_demo/modules/user_details/widgets/multi_select_selection.dart';
import 'package:sagar_core_ehs_demo/shared/constants/string_constant.dart';
import 'package:sagar_core_ehs_demo/shared/widgets/input_field.dart';
import 'package:sagar_core_ehs_demo/shared/widgets/base_text.dart';
import 'package:sagar_core_ehs_demo/shared/widgets/common_outline_button.dart';
import '../user_details_controller.dart';
import 'gender_selector.dart';

class UserDetailsForm extends GetView<UserDetailsController> {
  const UserDetailsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputTextField(
            controller: controller.nameController,
            hintText: StringConstant.name,
            validator: (value) =>
                value!.isEmpty ? StringConstant.pleaseEnterName : null,
          ),
          const SizedBox(height: 20),
          InputTextField(
            controller: controller.ageController,
            hintText: StringConstant.age,
            textInputType: TextInputType.number,
            maxLength: 3,
            validator: (value) =>
                value!.isEmpty ? StringConstant.pleaseEnterAge : null,
          ),
          const SizedBox(height: 20),
          InputTextField(
            controller: controller.phoneNumberController,
            hintText: StringConstant.phoneNumber,
            textInputType: TextInputType.number,
            maxLength: 10,
            validator: (value) {
              if (value!.isEmpty) return StringConstant.pleaseEnterPhoneNumber;
              if (value.length != 10) {
                return StringConstant.pleaseEnterValidPhoneNumber;
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          const BaseText(text: StringConstant.gender),
          const SizedBox(height: 10),
          const GenderSelector(),
          const SizedBox(height: 20),
          MultiSelectSection(
            title: StringConstant.whatYouPlay,
            items: controller.games,
            selectedItems: controller.selectedGames,
          ),
          const SizedBox(height: 20),
          MultiSelectSection(
            title: StringConstant.booksYouRead,
            items: controller.books,
            selectedItems: controller.selectedBooks,
          ),
          const SizedBox(height: 20),
          MultiSelectSection(
            title: StringConstant.citiesVisited,
            items: controller.cities,
            selectedItems: controller.selectedCities,
          ),
          const SizedBox(height: 20),
          CommonOutlineButton(
            onPressed: controller.submitData,
            text: StringConstant.submit,
            fontSize: 15,
          ),
        ],
      ),
    );
  }
}
