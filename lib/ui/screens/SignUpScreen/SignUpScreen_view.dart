import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_travelmate/app/app.router.dart';
import 'package:my_travelmate/app/utils.dart';
import 'package:my_travelmate/ui/screens/SignUpScreen/SignUpScreen_viewmodel.dart';
import 'package:my_travelmate/ui/tools/screen_size.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/color_constants.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpScreenViewModel>.reactive(
      onViewModelReady: (model) {

        },
      builder: (context, model, child) {

        return Scaffold(
          body: Container(
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
              child: SingleChildScrollView(
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
                            color: ColorConstants.primaryRed.withOpacity( 0.3)),
                      ),
                      child: Form(
                        key: model.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Signup',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller:model.nameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorConstants.mainwhite.withOpacity(  0.3),
                                hintText: 'Name',
                                hintStyle: TextStyle(color: ColorConstants.mainwhite),
                                prefixIcon:
                                Icon(Icons.person, color: ColorConstants.mainwhite),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: model.emailController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorConstants.mainwhite.withOpacity(  0.3),
                                hintText: 'Email',
                                hintStyle: TextStyle(color: ColorConstants.mainblack),
                                prefixIcon: Icon(Icons.email, color: Colors.white),
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
                              controller: model.phoneController,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorConstants.mainwhite.withOpacity(  0.3),
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(color: ColorConstants.mainwhite),
                                prefixIcon: Icon(Icons.contacts_outlined,
                                    color: ColorConstants.mainwhite),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: model.passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorConstants.mainwhite.withOpacity(  0.3),
                                hintText: 'Password',
                                hintStyle: TextStyle(color: ColorConstants.mainwhite),
                                prefixIcon:
                                Icon(Icons.lock, color: ColorConstants.mainwhite),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: model.cpasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorConstants.mainwhite.withOpacity( 0.3),
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(color: ColorConstants.mainwhite),
                                prefixIcon:
                                Icon(Icons.lock, color: ColorConstants.mainwhite),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (model.passwordController.text != value) {
                                  return 'Must be same as password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                            bool ?s= await model.register();
                            if(s==true){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration Successfull")));
                            navigationService.navigateTo(Routes.loginView);
                            }
                
                              },
                
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                ColorConstants.mainwhite.withOpacity( 0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Register',
                                style: TextStyle(color: ColorConstants.mainwhite),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: GoogleFonts.roboto(
                                      fontSize: 15, color: ColorConstants.mainwhite),
                                ),
                                SizedBox(width: 5),
                                TextButton(
                                  onPressed: () {
                                    navigationService.navigateTo(Routes.loginView);
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(color: ColorConstants.mainwhite),
                                  ),
                                ),
                              ],
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
        );
      },
      viewModelBuilder: () => SignUpScreenViewModel(),
    );
  }
}
