import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import '../../../models/login/LoginResModel.dart';
//import '../models/login/LoginResModel.dart';
import 'package:my_travelmate/app/utils.dart';

import '../../../models/profileupdate/Data.dart';
import '../../../services/api_services.dart'; // Make sure this contains userservice

class ProfileViewModel extends BaseViewModel {
  LoginResModel? user;
  String name = "";
  static final ApiEnvironment currentEnv = ApiEnvironment.dev;

  // Use the selected environment's base URL
   final String baseUrl = currentEnv.baseUrl;
  List<String> languageList = [
    "English", "Spanish", "French", "German", "Italian",
    "Chinese", "Japanese", "Hindi", "Arabic", "Russian",
  ];
  String? selectedLanguage;

  List<String> traveltypes = [
    "Bus", "Two wheeler", "Car", "Train", "Ship", "Air Line"
  ];
  String? selectedTravelType;

  final formkey = GlobalKey<FormState>();
  final TextEditingController usernamectrlr = TextEditingController();
  final TextEditingController alternativenoctlr = TextEditingController();
  final TextEditingController emailctlr = TextEditingController();
  final TextEditingController prefsizectlr = TextEditingController();
  final TextEditingController phnctlr = TextEditingController();
  final TextEditingController budgetctlr = TextEditingController();
  final TextEditingController availableday = TextEditingController();
  final TextEditingController availabledayto = TextEditingController();

  String ?proimage;
  String? id_proof;
  final ImagePicker picker = ImagePicker();
  XFile? image;
  XFile? idproof;

  void initState() {
    updateuser();
  }

  Future<void> updateuser() async {
    try {
      user = await userservice.getUser();
      if (user != null) {
        usernamectrlr.text = user!.name ?? "";
        emailctlr.text = user!.email ?? ""; // Fixed from name to email
        alternativenoctlr.text = user!.alternativePhone?.toString() ?? "";
        selectedLanguage = user!.language;
        selectedTravelType = user!.travelType;
        availableday.text = user!.fromDate ?? "";
        availabledayto.text = user!.toDate ?? "";
        phnctlr.text = user!.phone?.toString() ?? "";
        budgetctlr.text = user!.budget?.toString() ?? "";
        prefsizectlr.text=user!.groupSize.toString()??"";
        proimage = user!.image;
        print("profilepic::::$proimage");
        id_proof = user!.idProof;
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  Future<XFile?> pickimage() async {
    try {
      if (await Permission.camera.request().isDenied) {
        await Permission.camera.request();
      }
      final picked = await picker.pickImage(source: ImageSource.camera);
      return picked;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  Future<String?> pickdate(BuildContext context) async {
    try {
      DateTime currentDate = DateTime.now();
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.blue,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedDate != null) {
        return DateFormat('yyyy-MM-dd').format(pickedDate);
      }
      return null;
    } catch (e) {
      print('Error picking date: $e');
      return null;
    }
  }

  Future<void> updateProfile() async {
    try {
      if (formkey.currentState!.validate()) {
        // Assuming apiservice is available globally or injected
        Data? data=  await apiservice.postProfileDetails(
          name: usernamectrlr.text,
          phone: phnctlr.text,
          email: emailctlr.text,
          alternativePhone: alternativenoctlr.text,
          travelType: selectedTravelType ?? "",
          language: selectedLanguage ?? "",
          budget: budgetctlr.text,
          groupSize: prefsizectlr.text,
          fromDate: availableday.text,
          toDate: availabledayto.text,
          image: File(image!.path),  // Add image if picked
          idProof: File(idproof!.path),  // Add id proof if picked
        );
       if(data!=null){
         LoginResModel loginResModel=LoginResModel(
             access: user!.access,
             toDate: data.toDate,
             fromDate:data.fromDate ,id:user!.id ,image:data.image ,email:user!.email ,name:data.name,alternativePhone: data.alternativePhone,budget:data.budget ,groupSize:data.groupSize ,idProof: data.idProof,language:data.language ,phone:data.phone ,refresh:user!.refresh ,travelType: data.travelType
         );
         await userservice.saveUser(loginResModel);
       }

        // Update local user data



        notifyListeners();
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }
}