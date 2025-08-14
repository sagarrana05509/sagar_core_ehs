import 'package:flutter/material.dart';
import 'package:sagar_core_ehs_demo/shared/widgets/input_field.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputTextField(
      controller: controller,
      hintText: "Search",
      onChanged: onChanged,
    );
  }
}
