import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sagar_core_ehs_demo/modules/user_details/widgets/multi_select_dialogue.dart';
import 'package:sagar_core_ehs_demo/shared/constants/color_constants.dart';
import 'package:sagar_core_ehs_demo/shared/widgets/base_text.dart';
import '../user_details_controller.dart';

class MultiSelectSection extends StatelessWidget {
  final String title;
  final RxList<String> items;
  final RxList<String> selectedItems;

  const MultiSelectSection({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Get.find<UserDetailsController>().searchText.clear();
            openMultiSelectDialog(items, selectedItems, title);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText(text: title),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(color: ColorConstants.darkGreenColor, height: 1),
        const SizedBox(height: 10),
        Obx(
          () => Wrap(
            spacing: 10,
            runSpacing: 10,
            children: selectedItems
                .map(
                  (value) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: BaseText(
                      text: value,
                      textColor: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
