import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sagar_core_ehs_demo/shared/constants/constants.dart';
import 'package:sagar_core_ehs_demo/shared/widgets/base_text.dart';
import '../user_details_controller.dart';

class GenderSelector extends GetView<UserDetailsController> {
  const GenderSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => controller.gender.value = StringConstant.male,
          child: Row(
            children: [
              Obx(
                () => Icon(
                  controller.gender.value == StringConstant.male
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                ),
              ),
              const SizedBox(width: 10),
              const BaseText(text: StringConstant.male),
            ],
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () => controller.gender.value = StringConstant.female,
          child: Row(
            children: [
              Obx(
                () => Icon(
                  controller.gender.value == StringConstant.female
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                ),
              ),
              const SizedBox(width: 10),
              const BaseText(text: StringConstant.female),
            ],
          ),
        ),
      ],
    );
  }
}
