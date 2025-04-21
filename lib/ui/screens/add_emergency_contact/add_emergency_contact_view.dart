import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_travelmate/app/utils.dart';
import 'package:stacked/stacked.dart';
import 'add_emergency_contact_view_model.dart';
import '../../../constants/color_constants.dart'; // Assuming this exists based on prior examples

class AddEmergencyContactView extends StatelessWidget {
  const AddEmergencyContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddEmergencyContactViewModel>.reactive(
      viewModelBuilder: () => AddEmergencyContactViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Colors.grey[100], // Consistent background
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => navigationService.popRepeated(1),
          ),
          backgroundColor: ColorConstants.primaryRed, // Theme color
          elevation: 4,
          title: Text(
            'Add Emergency Contact',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: viewModel.formKey,
            child: SingleChildScrollView(
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Name Field
                      _buildTextField(
                        controller: viewModel.nameController,
                        label: 'Full Name *',
                        validator: viewModel.validateName,
                      ),
                      const SizedBox(height: 16),

                      // Relationship Field
                      _buildTextField(
                        controller: viewModel.relationshipController,
                        label: 'Relationship *',
                        hint: 'e.g. Parent, Spouse, Sibling',
                        validator: viewModel.validateRelationship,
                      ),
                      const SizedBox(height: 16),

                      // Phone Number Field
                      _buildTextField(
                        controller: viewModel.phoneController,
                        label: 'Phone Number *',
                        hint: 'e.g. +1 (123) 456-7890',
                        keyboardType: TextInputType.phone,
                        validator: viewModel.validatePhone,
                      ),
                      const SizedBox(height: 16),

                      // Email Field (Optional)
                      _buildTextField(
                        controller: viewModel.emailController,
                        label: 'Email (Optional)',
                        hint: 'e.g. contact@example.com',
                        keyboardType: TextInputType.emailAddress,
                        validator: viewModel.validateEmail,
                      ),
                      const SizedBox(height: 16),

                      // Priority Dropdown
                      DropdownButtonFormField<int>(
                        value: viewModel.selectedPriority,
                        decoration: InputDecoration(
                          labelText: 'Priority *',
                          labelStyle: GoogleFonts.roboto(color: Colors.grey[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        items: [1, 2, 3].map((priority) {
                          return DropdownMenuItem<int>(
                            value: priority,
                            child: Text(
                              '$priority ${viewModel.getPriorityLabel(priority)}',
                              style: GoogleFonts.roboto(color: ColorConstants.mainblack),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          viewModel.selectedPriority = value!;
                          viewModel.notifyListeners();
                        },
                        validator: (value) => value == null ? 'Please select priority' : null,
                      ),
                      const SizedBox(height: 32),

                      // Save Button
                      ElevatedButton(
                        onPressed: viewModel.isBusy ? null : () => viewModel.saveContact(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.primaryRed, // Theme color
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                        ),
                        child: viewModel.isBusy
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                          'SAVE CONTACT',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
    );
  }

  // Reusable TextField widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    String? hint,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: GoogleFonts.roboto(color: Colors.grey[700]),
        hintStyle: GoogleFonts.roboto(color: Colors.grey[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validator,
      style: GoogleFonts.roboto(color: ColorConstants.mainblack),
    );
  }
}