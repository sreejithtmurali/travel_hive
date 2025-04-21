import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import '../../../constants/color_constants.dart'; // Assuming this exists
import 'my_emergency_contact_view_model.dart';

class MyEmergencyContactView extends StatelessWidget {
  const MyEmergencyContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyEmergencyContactViewModel>.reactive(
      viewModelBuilder: () => MyEmergencyContactViewModel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Colors.grey[100], // Consistent background
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: ColorConstants.primaryRed, // Theme color
          elevation: 4,
          title: Text(
            'Emergency Contacts',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.restart_alt, color: Colors.white),
              onPressed: () => viewModel.init(),
              tooltip: 'Refresh',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorConstants.primaryRed, // Theme color
          onPressed: () => viewModel.navigateToAddContact(),
          tooltip: 'Add Contact',
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: _buildBody(context, viewModel),
      ),
    );
  }

  // Main body with state handling
  Widget _buildBody(BuildContext context, MyEmergencyContactViewModel viewModel) {
    if (viewModel.isBusy) {
      return const Center(
        child: CircularProgressIndicator(color: ColorConstants.primaryRed),
      );
    }

    // Handle null or error state
    if (viewModel.emergencyContacts == null) {
      return _buildErrorView(context, viewModel);
    }

    // Handle empty contacts list
    if (viewModel.emergencyContacts!.isEmpty) {
      return _buildNoContactsView(context, viewModel);
    }

    // Show contacts list
    return _buildContactsList(viewModel);
  }

  // Error view for failed data fetch
  Widget _buildErrorView(BuildContext context, MyEmergencyContactViewModel viewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            "Failed to Load Contacts",
            style: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Something went wrong. Please try again.",
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => viewModel.init(),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primaryRed,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Text(
              "Retry",
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // No emergency contacts view
  Widget _buildNoContactsView(BuildContext context, MyEmergencyContactViewModel viewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.contact_emergency,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            "No Emergency Contacts Available",
            style: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Add a contact to get started!",
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => viewModel.navigateToAddContact(),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primaryRed,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Text(
              "Add Contact",
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Contacts list view
  Widget _buildContactsList(MyEmergencyContactViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: viewModel.emergencyContacts!.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final contact = viewModel.emergencyContacts![index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contact.name ?? "Unnamed Contact",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: ColorConstants.mainblack,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildContactDetail('Relationship:', contact.relationship ?? "Not specified"),
                        _buildContactDetail('Phone:', "${contact.phone ?? "Not specified"}"),
                        if (contact.email != null && contact.email!.isNotEmpty)
                          _buildContactDetail('Email:', contact.email!),
                        _buildContactDetail('Priority:', viewModel.getPriorityLabel(contact.priority ?? 'N/A')),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => viewModel.deleteContact(contact),
                    tooltip: 'Delete Contact',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper method for contact detail rows
  Widget _buildContactDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: ColorConstants.mainblack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}