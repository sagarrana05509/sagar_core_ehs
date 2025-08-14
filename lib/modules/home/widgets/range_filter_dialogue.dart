import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home_controller.dart';
import 'package:sagar_core_ehs_demo/shared/constants/string_constant.dart';

void showRangeFilterDialog(HomeController controller) {
  Get.dialog(
    AlertDialog(
      title: Text(StringConstant.selectAgeRange),
      content: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RangeSlider(
              values: RangeValues(
                controller.minValue.value,
                controller.maxValue.value,
              ),
              min: 0,
              max: 100,
              divisions: 100,
              labels: RangeLabels(
                controller.minValue.value.round().toString(),
                controller.maxValue.value.round().toString(),
              ),
              onChanged: (values) =>
                  controller.setRange(values.start, values.end),
            ),
            Text(
              "${StringConstant.from} ${controller.minValue.value.round()} ${StringConstant.to} ${controller.maxValue.value.round()}",
            ),
          ],
        );
      }),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: const Text(StringConstant.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
            controller.getRangeData();
          },
          child: Text(StringConstant.apply),
        ),
      ],
    ),
  );
}
