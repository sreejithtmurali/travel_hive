import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:my_travelmate/app/utils.dart';
import 'package:stacked/stacked.dart';
class SignUpScreenViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();

  Future<bool?> register() async {
    if (formKey.currentState!.validate()) {
    return  await apiservice.onRegister(nameController.text.trim(), phoneController.text.trim(), emailController.text.trim(), passwordController.text.trim());

    }
    return null;
  }

}
