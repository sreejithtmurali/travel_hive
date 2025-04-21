import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_travelmate/app/app.router.dart';
import 'package:my_travelmate/app/utils.dart';
import 'package:stacked/stacked.dart';
import '../../../constants/color_constants.dart';
import '../login/login_view.dart';
import 'Profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      onViewModelReady: (model) {
        model.initState();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorConstants.primaryRed,
            elevation: 4,
            title: Text(
              "My Profile",
              style: GoogleFonts.roboto(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () async {
                  await userservice.clearUser();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                        (route) => false,
                  );
                },
                icon: const Icon(Icons.power_settings_new_sharp, color: Colors.white),
              ),
            ],
          ),
          body: Container(
            color: Colors.grey[100],
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: model.formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle("Profile Picture"),
                        _buildProfileImageCard(model),
                        _buildSectionTitle("Personal Information"),
                        _buildTextFormFieldCard(
                          controller: model.usernamectrlr,
                          label: "Name",
                          hint: "Enter your name",
                          icon: Icons.person,
                          validator: (v) => v!.isEmpty ? "Name is required" : null,
                        ),
                        _buildTextFormFieldCard(
                          controller: model.emailctlr,
                          label: "Email",
                          hint: "Enter your email",
                          icon: Icons.email,
                          readOnly: true,
                          validator: (v) => v!.isEmpty ? "Email is required" : null,
                        ),
                        _buildTextFormFieldCard(
                          controller: model.phnctlr,
                          label: "Phone",
                          hint: "Enter your phone number",
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          validator: (v) => v!.isEmpty ? "Phone number is required" : null,
                        ),
                        _buildTextFormFieldCard(
                          controller: model.alternativenoctlr,
                          label: "Alternative Number",
                          hint: "Enter alternative number",
                          icon: Icons.phone_android,
                          keyboardType: TextInputType.phone,
                          validator: (v) => v!.isEmpty ? "Alternative number is required" : null,
                        ),
                        _buildSectionTitle("Travel Preferences"),
                        _buildTextFormFieldCard(
                          controller: model.prefsizectlr,
                          label: "Preferred Group Size",
                          hint: "Enter group size",
                          icon: Icons.group,
                          keyboardType: TextInputType.number,
                          validator: (v) => v!.isEmpty ? "Group size is required" : null,
                        ),
                        _buildTextFormFieldCard(
                          controller: model.budgetctlr,
                          label: "Budget",
                          hint: "Enter your budget",
                          icon: Icons.attach_money,
                          keyboardType: TextInputType.number,
                          validator: (v) => v!.isEmpty ? "Budget is required" : null,
                        ),
                        _buildDropdownCard(
                          label: "Travel Type",
                          value: model.selectedTravelType,
                          items: model.traveltypes,
                          onChanged: (value) {
                            model.selectedTravelType = value;
                            model.notifyListeners();
                          },
                        ),
                        _buildDropdownCard(
                          label: "Language",
                          value: model.selectedLanguage,
                          items: model.languageList,
                          onChanged: (value) {
                            model.selectedLanguage = value;
                            model.notifyListeners();
                          },
                        ),
                        _buildSectionTitle("Availability"),
                        _buildDateFormFieldCard(
                          label: "From Date",
                          controller: model.availableday,
                          hint: "Select start date",
                          model: model,
                          context: context,
                          validator: (v) => v!.isEmpty ? "Start date is required" : null,
                        ),
                        _buildDateFormFieldCard(
                          label: "To Date",
                          controller: model.availabledayto,
                          hint: "Select end date",
                          model: model,
                          context: context,
                          validator: (v) => v!.isEmpty ? "End date is required" : null,
                        ),
                        _buildSectionTitle("ID Proof"),
                        _buildIdProofCard(model),
                        const SizedBox(height: 30),
                        _buildActionButtons(model, context), // Updated method
                        const SizedBox(height: 20),
                        _buildNavigationButtons(context, model),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => ProfileViewModel(),
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

  Widget _buildProfileImageCard(ProfileViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: _buildProfileImage(model),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () async {
                  var data = await model.pickimage();
                  if (data != null) {
                    model.image = data;
                    model.notifyListeners();
                  }
                },
                child: const CircleAvatar(
                  radius: 18,
                  backgroundColor: ColorConstants.primaryRed,
                  child: Icon(Icons.edit, size: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormFieldCard({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool readOnly = false,
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
                    style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller,
                readOnly: readOnly,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                validator: validator,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownCard({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
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
                  Icon(Icons.list, color: ColorConstants.primaryRed, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                items: items.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: onChanged,
                validator: (v) => v == null ? "Please select an option" : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateFormFieldCard({
    required String label,
    required TextEditingController controller,
    required String hint,
    required ProfileViewModel model,
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
                    style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[700]),
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onTap: () async {
                  var s = await model.pickdate(context);
                  if (s != null) {
                    controller.text = s;
                    model.notifyListeners();
                  }
                },
                validator: validator,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIdProofCard(ProfileViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(Icons.verified_user, color: ColorConstants.primaryRed, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    "ID Proof",
                    style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                var data = await model.pickimage();
                if (data != null) {
                  model.idproof = data;
                  model.notifyListeners();
                }
              },
              child: Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
                  color: ColorConstants.primaryRed.withOpacity(0.1),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
                  child: _buildIdProof(model),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Upload any ID proof *",
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(ProfileViewModel model, BuildContext context) {
    return Column(
      children: [
        // Update Profile Button
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
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
              if (model.formkey.currentState!.validate()) {
                model.setBusy(true);
                model.updateProfile().then((_) {
                  model.setBusy(false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Profile updated successfully!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }).catchError((e) {
                  model.setBusy(false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Failed to update profile: $e"),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                });
              }
            },
            child: model.isBusy
                ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
                : Text(
              "Update Profile",
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12), // Spacing between buttons
        // My Emergency Contacts Button
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
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
              navigationService.navigateTo(Routes.myEmergencyContactView);
            },
            child: Text(
              "My Emergency Contacts",
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons(BuildContext context, ProfileViewModel model) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              navigationService.navigateTo(Routes.myTripsView);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(
              "My Trips",
              style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 10),
        FloatingActionButton.small(
          onPressed: () {
           navigationService.navigateTo(Routes.createTripView);
          },
          backgroundColor: ColorConstants.primaryRed,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildProfileImage(ProfileViewModel model) {
    if (model.image != null) {
      return Image.file(
        File(model.image!.path),
        fit: BoxFit.cover,
        height: 120,
        width: 120,
      );
    } else if (model.proimage != null) {
      return CachedNetworkImage(
        imageUrl: "${model.baseUrl}${model.proimage}",
        fit: BoxFit.cover,
        height: 120,
        width: 120,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(
          Icons.error,
          size: 50,
          color: Colors.grey,
        ),
      );
    } else {
      return Container(
        color: Colors.grey[200],
        child: const Icon(
          Icons.person,
          size: 50,
          color: Colors.grey,
        ),
      );
    }
  }

  Widget _buildIdProof(ProfileViewModel model) {
    if (model.idproof != null) {
      return Image.file(
        File(model.idproof!.path),
        fit: BoxFit.cover,
      );
    } else if (model.id_proof != null && model.id_proof!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: "${model.baseUrl}${model.id_proof}",
        fit: BoxFit.cover,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(
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
}