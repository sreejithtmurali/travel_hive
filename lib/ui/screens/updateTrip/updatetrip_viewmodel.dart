import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_travelmate/app/utils.dart';
import 'package:stacked/stacked.dart';

import '../../../models/mytrips/Data.dart';
import '../../../services/api_services.dart';

class UpdateTripViewModel extends BaseViewModel {
  final List<String> travelTypes = ["Bike", "Car", "Bus", "Train"];
  String? selectedTravelType;
  String? selectedValue;
  static final ApiEnvironment currentEnv = ApiEnvironment.dev;

  // Use the selected environment's base URL
  final String baseUrl = currentEnv.baseUrl;
  DateTime selectedDate = DateTime.now();
  File? selectedImage;
  final MyTrip myTrip;
  UpdateTripViewModel({required this.myTrip});
  // Controllers
  final TextEditingController tripNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final TextEditingController groupSizeController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController FromdateController = TextEditingController();
  final TextEditingController to_dateController = TextEditingController();

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage = File(image.path);
      notifyListeners();
    }
  }

  DateTime? fromDate;
  DateTime? toDate;
  init() {
    tripNameController.text = myTrip.tripName!;
    locationController.text = myTrip.location!;
    desController.text = myTrip.description!;
    groupSizeController.text = myTrip.groupSize.toString();
    budgetController.text = myTrip.budget.toString();
    FromdateController.text = myTrip.fromDate!;
    to_dateController.text = myTrip.toDate!;
    fromDate = DateTime.tryParse(myTrip.fromDate.toString());
    toDate = DateTime.tryParse(myTrip.toDate.toString());
    selectedTravelType = myTrip.travelType;
    notifyListeners();
  }

  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      controller.text = DateFormat('yyyy-MM-dd')
          .format(pickedDate); // Ensuring correct format
      notifyListeners();
    }
  }

  Future<bool?> createtrip() async {
    bool? s = await apiservice.updatetrip(
        trip_name: tripNameController.text,
        description: desController.text,
        location: locationController.text,
        travel_type: selectedTravelType!,
        budget: budgetController.text,
        group_size: groupSizeController.text,
        from_date: FromdateController.text,
        to_date: to_dateController.text,
        image: selectedImage,
        id: myTrip.id!);
    if (s == true) {
      to_dateController.clear();
      desController.clear();
      locationController.clear();
      selectedImage = null;
      budgetController.clear();
      groupSizeController.clear();
      FromdateController.clear();
      to_dateController.clear();
      selectedImage = null;
    }
    return s;
  }
}
