import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:my_travelmate/app/app.router.dart';
import 'package:my_travelmate/app/utils.dart';

import 'package:stacked/stacked.dart';


import '../../../models/login/LoginResModel.dart';

class LoginViewModel extends BaseViewModel {
  TextEditingController usernamectlr = TextEditingController();
  TextEditingController passwordctlr = TextEditingController();
  final formkey = GlobalKey<FormState>();
  LoginResModel? user;
  var obsure = true;
  void togglepassword() {
    obsure = !obsure;
    notifyListeners();
  }

  Future<bool?> login() async {
    if (formkey.currentState!.validate()) {
      user = await apiservice.onLogin( usernamectlr.text.trim(),  passwordctlr.text.trim());
      print("user:$user");
      notifyListeners();
      if(user!=null){
        await userservice.saveUser(user!);
        await apiservice.getProfile();
        navigationService.pushNamedAndRemoveUntil(Routes.dashboardView);
        return true;
      }
      else{
        return false;
      }
    }
    return null;
  }
}
