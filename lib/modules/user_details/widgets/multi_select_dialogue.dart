import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sagar_core_ehs_demo/shared/shared.dart';

void openMultiSelectDialog(
  RxList<String> filteredItems,
  RxList<String> selectedItems,
  String title,
) {
  RxBool isSearch = false.obs;
  RxList<String> searchList = <String>[].obs;

  showDialog(
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: StringConstant.search,
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    isSearch.value = true;
                    searchList.value = filteredItems
                        .where(
                          (item) => item.toLowerCase().contains(
                            value.toLowerCase().trim(),
                          ),
                        )
                        .toList();
                  } else {
                    isSearch.value = false;
                  }
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(
                  () => ListView(
                    children: (isSearch.value ? searchList : filteredItems).map(
                      (item) {
                        final isSelected = selectedItems.contains(item);
                        return CheckboxListTile(
                          value: isSelected,
                          title: Text(item),
                          onChanged: (checked) {
                            if (checked == true) {
                              selectedItems.add(item);
                            } else {
                              selectedItems.remove(item);
                            }
                          },
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(StringConstant.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(StringConstant.ok),
          ),
        ],
      );
    },
  );
}
