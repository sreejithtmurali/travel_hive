import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_travelmate/ui/screens/updateTrip/updatetrip_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/color_constants.dart';
import '../../../models/mytrips/Data.dart';


class UpdateTripView extends StatelessWidget {
  final MyTrip myTrip;
   const UpdateTripView({super.key, required this.myTrip});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateTripViewModel>.reactive(
      onViewModelReady: (model) {
        model.init();
      },
      builder: (context, model, child) {
        final GlobalKey<FormState> formKey = GlobalKey<FormState>();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorConstants.primaryRed,
            elevation: 4,
            title: Text(
              "Plan My Trip",
              style: GoogleFonts.roboto(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Container(
            color: Colors.grey[100], // Light background for contrast
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle("Trip Details"),
                      _buildTextFormFieldCard(
                        controller: model.tripNameController,
                        label: "Trip Name",
                        hint: "Enter trip name",
                        icon: Icons.trip_origin,
                        validator: (value) =>
                        value!.isEmpty ? "Trip name is required" : null,
                      ),
                      _buildTextFormFieldCard(
                        controller: model.locationController,
                        label: "Location",
                        hint: "Enter location",
                        icon: Icons.location_on,
                        validator: (value) =>
                        value!.isEmpty ? "Location is required" : null,
                      ),
                      _buildTextFormFieldCard(
                        controller: model.desController,
                        label: "Description",
                        hint: "Trip description",
                        icon: Icons.description,
                        maxLines: 6,
                        validator: (value) => value!.isEmpty
                            ? "Trip description is required"
                            : null,
                      ),
                      _buildSectionTitle("Travel Preferences"),
                      _buildDropdownCard(model),
                      _buildTextFormFieldCard(
                        controller: model.groupSizeController,
                        label: "Group Size",
                        hint: "Preferred group size",
                        icon: Icons.group,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Group size is required";
                          }
                          if (int.tryParse(value) == null ||
                              int.parse(value) <= 0) {
                            return "Enter a valid number greater than 0";
                          }
                          return null;
                        },
                      ),
                      _buildTextFormFieldCard(
                        controller: model.budgetController,
                        label: "Budget",
                        hint: "Enter your budget",
                        icon: Icons.attach_money,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Budget is required";
                          }
                          if (int.tryParse(value) == null ||
                              int.parse(value) <= 0) {
                            return "Enter a valid budget greater than 0";
                          }
                          return null;
                        },
                      ),
                      _buildSectionTitle("Travel Dates"),
                      _buildDateFormFieldCard(
                        label: "From Date",
                        hint: "Select From Date",
                        controller: model.FromdateController,
                        isFromDate: true,
                        model: model,
                        context: context,
                        validator: (value) =>
                        value!.isEmpty ? "From date is required" : null,
                      ),
                      _buildDateFormFieldCard(
                        label: "To Date",
                        hint: "Select To Date",
                        controller: model.to_dateController,
                        isFromDate: false,
                        model: model,
                        context: context,
                        validator: (value) =>
                        value!.isEmpty ? "To date is required" : null,
                      ),
                      _buildSectionTitle("Trip Image"),
                      _buildImagePickerCard(model),
                      const SizedBox(height: 30),
                      _buildSubmitButton(model, formKey,context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => UpdateTripViewModel(myTrip: myTrip),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 15),
      child: Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: ColorConstants.primaryRed,
        ),
      ),
    );
  }

  Widget _buildTextFormFieldCard({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: ColorConstants.primaryRed, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller,
                maxLines: maxLines,
                keyboardType: keyboardType,
                inputFormatters: keyboardType == TextInputType.number
                    ? [FilteringTextInputFormatter.digitsOnly]
                    : [],
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                validator: validator,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownCard(UpdateTripViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.directions, color: ColorConstants.primaryRed, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    "Travel Type",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField2<String>(
                value: model.selectedTravelType,
                isExpanded: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                hint: Text(
                  'Select travel type',
                  style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                ),
                items: model.travelTypes
                    .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 14),
                  ),
                ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a travel type';
                  }
                  return null;
                },
                onChanged: (value) {
                  model.selectedTravelType = value;
                  model.notifyListeners();
                },
                onSaved: (value) {
                  model.selectedValue = value.toString();
                  model.notifyListeners();
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: ColorConstants.mainblack,
                  ),
                  iconSize: 24,
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateFormFieldCard({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool isFromDate,
    required UpdateTripViewModel model,
    required BuildContext context,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, color: ColorConstants.primaryRed, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.calendar_month, color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onTap: () => model.selectDate(context, controller),
                validator: validator,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePickerCard(UpdateTripViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: GestureDetector(
          onTap: model.pickImage,
          child: Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ColorConstants.primaryRed.withOpacity(0.1),
            ),
            child: Center(
              child:_buildtripimage(model)
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(UpdateTripViewModel model, GlobalKey<FormState> formKey,BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorConstants.primaryRed, Colors.redAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            if (model.selectedImage == null&&model.myTrip.image==null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Please upload a trip image"),
                  backgroundColor: Colors.redAccent,
                ),
              );
            } else {
              // Simulate submission with a loading state
              model.setBusy(true);
              Future.delayed(const Duration(seconds: 2), () async {
                model.setBusy(false);
                bool?s=await model.createtrip();
               if(s!){
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                     content: Text("Trip Updated successfully!"),
                     backgroundColor: Colors.green,
                   ),
                 );
               }else{
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                     content: Text("Trip Updation failed!"),
                     backgroundColor: Colors.green,
                   ),
                 );
               }
              });
            }
          }
        },
        child: model.isBusy
            ? const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )
            : Text(
          "Submit",
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
Widget _buildtripimage(UpdateTripViewModel model) {
  if (model.selectedImage != null) {
    return Image.file(
      File(model.selectedImage!.path),
      fit: BoxFit.cover,
    );
  } else if (model.myTrip.image != null && model.myTrip.image!.isNotEmpty) {
    return CachedNetworkImage(
      imageUrl: "${model.baseUrl}${model.myTrip.image}",
      fit: BoxFit.cover,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) =>
      const Icon(
        Icons.image,
        size: 50,
        color: Colors.grey,
      ),
    );
  } else {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.upload, size: 50, color: ColorConstants.primaryRed),
        const SizedBox(height: 8),
        Text(
          "Upload ID Proof",
          style: GoogleFonts.roboto(
            fontSize: 14,
            color: ColorConstants.primaryRed,
          ),
        ),
      ],
    );
  }
}