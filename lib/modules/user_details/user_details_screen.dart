import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sagar_core_ehs_demo/modules/user_details/user_details_controller.dart';
import 'package:sagar_core_ehs_demo/modules/user_details/widgets/user_details_form.dart';

class UserDetailsScreen extends GetView<UserDetailsController> {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: UserDetailsForm(),
        ),
      ),
    );
  }
}
