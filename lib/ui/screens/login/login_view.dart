import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_travelmate/app/app.router.dart';
import 'package:my_travelmate/app/utils.dart';
import 'package:my_travelmate/ui/tools/screen_size.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/color_constants.dart';
import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      onViewModelReady: (model) {},
      builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: ScreenSize.height,
              width: ScreenSize.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: ColorConstants.mainblack.withOpacity(  0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: ColorConstants.primaryRed.withOpacity(  0.3)),
                      ),
                      child: Form(
                        key: model.formkey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.mainblack,
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: model.usernamectlr,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                  ColorConstants.mainwhite.withOpacity(  0.3),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(color: ColorConstants.mainwhite),
                                  prefixIcon:
                                  Icon(Icons.email, color: ColorConstants.mainwhite),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: model.passwordctlr,
                                obscureText: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                  ColorConstants.mainwhite.withOpacity(  0.3),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      color:
                                      ColorConstants.mainwhite.withOpacity(  0.4)),
                                  prefixIcon: Icon(Icons.lock,
                                      color:
                                      ColorConstants.mainwhite.withOpacity(  0.4)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 4) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    // Navigate to forgot password screen
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(color: ColorConstants.mainwhite),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () async {
                                model.login();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  ColorConstants.mainwhite.withOpacity(  0.3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(color: ColorConstants.mainwhite),
                                ),
                              ),
                              SizedBox(height: 20),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Expanded(
                              //         child: Divider(
                              //             thickness: 1,
                              //             endIndent: 1,
                              //             indent: 1,
                              //             color: ColorConstants.primaryRed
                              //                 .withOpacity(  0.5))),
                              //     Text(
                              //       'Or',
                              //       style: TextStyle(
                              //           color: ColorConstants.mainwhite, fontSize: 17),
                              //     ),
                              //     Expanded(
                              //         child: Divider(
                              //             thickness: 1,
                              //             endIndent: 1,
                              //             indent: 1,
                              //             color: ColorConstants.primaryRed
                              //                 .withOpacity(  0.5))),
                              //   ],
                              // ),
                              // SizedBox(height: 10),
                              // Text(
                              //   'login with',
                              //   style: TextStyle(
                              //       color: ColorConstants.mainwhite, fontSize: 15),
                              // ),
                              // SizedBox(height: 10),
                              // IconButton(
                              //     onPressed: () {},
                              //     icon: FaIcon(
                              //       FontAwesomeIcons.google,
                              //       size: 30,
                              //       color: ColorConstants.mainwhite.withOpacity(  0.3),
                              //     )),
                              // SizedBox(height: 10),
                              TextButton(
                                onPressed: () {
                                  navigationService.navigateTo(Routes.signUpScreen);
                                  },
                                child: Text(
                                  "Don't have an account? Sign Up",
                                  style: TextStyle(color: ColorConstants.mainwhite),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
