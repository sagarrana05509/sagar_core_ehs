import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sagar_core_ehs_demo/shared/widgets/base_text.dart';
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
            SizedBox(height: 10),
            InkWell(
              onTap: () =>
                  controller.notSyncData.value = !controller.notSyncData.value,
              child: Row(
                children: [
                  Obx(
                    () => Icon(
                      controller.notSyncData.value
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                    ),
                  ),
                  SizedBox(width: 10),
                  BaseText(text: "Not Async Data"),
                ],
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () =>
                  controller.syncData.value = !controller.syncData.value,
              child: Row(
                children: [
                  Icon(
                    controller.syncData.value
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                  ),
                  SizedBox(width: 10),
                  BaseText(text: "Sync Data"),
                ],
              ),
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
