import 'package:flutter/material.dart';
import 'package:my_travelmate/app/utils.dart';
import 'package:stacked/stacked.dart';

class AddEmergencyContactViewModel extends BaseViewModel {

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final relationshipController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  int selectedPriority = 1;


  @override
  void dispose() {
    nameController.dispose();
    relationshipController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  // Validation methods
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validateRelationship(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Relationship is required';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    // Simple phone validation - can be enhanced based on requirements
    final phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');
    if (!phoneRegex.hasMatch(value.replaceAll(RegExp(r'[\s\-\(\)]'), ''))) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Email is optional
    }

    // Email validation
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Helper method for priority label
  String getPriorityLabel(int priority) {
    switch (priority) {

      case 1:
        return '(High)';
      case 2:
        return '(Medium)';
      case 3:
        return '(Low)';
      default:
        return '';
    }
  }

  // Save contact method
  Future<void> saveContact() async {
    if (formKey.currentState!.validate()) {
      try {
        setBusy(true);

        bool ?s = await apiservice.addEmergencyContact(
            name: nameController.text,
            relationship: relationshipController.text,
            phone: phoneController.text,
            email: emailController.text,
            priority: selectedPriority);
        if (s == true) {
          emailController.clear();
          nameController.clear();
          relationshipController.clear();
          phoneController.clear();
          notifyListeners();
        }
        // Add contact using servic
      } finally {
        setBusy(false);
      }
    }
  }
}

// Emergency contact model (models/emergency_contact.dart)
class EmergencyContact {
  final String id;
  final String name;
  final String relationship;
  final String phoneNumber;
  final String? email;
  final int priority;

  EmergencyContact({
    required this.id,
    required this.name,
    required this.relationship,
    required this.phoneNumber,
    this.email,
    required this.priority,
  });

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'relationship': relationship,
      'phoneNumber': phoneNumber,
      'email': email,
      'priority': priority,
    };
  }

  // Create from Map
  factory EmergencyContact.fromMap(Map<String, dynamic> map) {
    return EmergencyContact(
      id: map['id'],
      name: map['name'],
      relationship: map['relationship'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      priority: map['priority'],
    );
  }
}

// Emergency contact service (services/emergency_contact_service.dart)
class EmergencyContactService {
  final List<EmergencyContact> _contacts = [];

  List<EmergencyContact> get contacts => _contacts;

  // Add emergency contact
  Future<void> addEmergencyContact(EmergencyContact contact) async {
    // Here you would typically save to local storage or database
    // For example using shared_preferences, sqflite, or hive

    _contacts.add(contact);

    // Mock delay to simulate storage operation
    await Future.delayed(const Duration(milliseconds: 500));
  }

  // Delete emergency contact
  Future<void> deleteEmergencyContact(String id) async {
    _contacts.removeWhere((contact) => contact.id == id);

    // Mock delay to simulate storage operation
    await Future.delayed(const Duration(milliseconds: 300));
  }

  // Get all emergency contacts
  Future<List<EmergencyContact>> getEmergencyContacts() async {
    // In a real implementation, you would fetch from storage

    // Sort by priority
    _contacts.sort((a, b) => a.priority.compareTo(b.priority));
    return _contacts;
  }
}