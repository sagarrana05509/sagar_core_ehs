import 'package:flutter/material.dart';
import 'package:sagar_core_ehs_demo/models/user_profile_model.dart';
import 'package:sagar_core_ehs_demo/shared/shared.dart';
import 'package:sagar_core_ehs_demo/shared/widgets/base_text.dart';
import 'package:sagar_core_ehs_demo/shared/constants/string_constant.dart';

class UserList extends StatelessWidget {
  final List<UserProfile> users;
  final void Function(int oldIndex, int newIndex) onReorder;

  const UserList({super.key, required this.users, required this.onReorder});

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      onReorder: onReorder,
      children: [
        for (int i = 0; i < users.length; i++)
          Container(
            key: Key(i.toString()),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: ColorConstants.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: _buildUserTile(users[i]),
          ),
      ],
    );
  }

  Widget _buildUserTile(UserProfile user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(text: "${StringConstant.nameLabel} ${user.name}"),
        const SizedBox(height: 10),
        BaseText(text: "${StringConstant.genderLabel} ${user.gender}"),
        const SizedBox(height: 10),
        BaseText(text: "${StringConstant.ageLabel} ${user.age}"),
        const SizedBox(height: 10),
        BaseText(
          text:
              "${StringConstant.syncLabel} ${user.isSync == 1 ? StringConstant.synced : StringConstant.notSynced}",
        ),
      ],
    );
  }
}
