import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sagar_core_ehs_demo/modules/home/home_controller.dart';
import 'package:sagar_core_ehs_demo/modules/home/widgets/range_filter_dialogue.dart';
import 'package:sagar_core_ehs_demo/modules/home/widgets/search_field.dart';
import 'package:sagar_core_ehs_demo/modules/home/widgets/user_list.dart';
import 'package:sagar_core_ehs_demo/routes/routes.dart';
import 'package:sagar_core_ehs_demo/shared/widgets/base_text.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: controller.fetchData,
        child: const Icon(Icons.sync),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const BaseText(text: "User List"),
        actions: [
          _buildAddButton(),
          const SizedBox(width: 20),
          _buildSortButton(),
          const SizedBox(width: 20),
          _buildFilterButton(),
          const SizedBox(width: 20),
        ],
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SearchField(
                controller: controller.searchController,
                onChanged: controller.onChange,
              ),
              SizedBox(height: 20),
              Expanded(
                child: controller.userList.isEmpty
                    ? const Center(child: BaseText(text: "User Not Found"))
                    : UserList(
                        users: controller.userList,
                        onReorder: controller.reorder,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton() => GestureDetector(
    onTap: () => Get.toNamed(Routes.USERDETAILS),
    child: Container(
      height: 30,
      width: 30,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.add, color: Colors.white),
    ),
  );

  Widget _buildSortButton() => GestureDetector(
    onTap: controller.ascendingDescendingData,
    child: Obx(
      () => BaseText(text: controller.isAscending.value ? "AZ" : "ZA"),
    ),
  );

  Widget _buildFilterButton() => GestureDetector(
    onTap: () => showRangeFilterDialog(controller),
    child: const Icon(Icons.filter_alt),
  );
}
