import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../app/utils.dart';
import '../../../models/getallemergency/Data.dart';
class SOSViewModel extends BaseViewModel {
  final LocationService _locationService = LocationService();
  String emergencyContact = "100"; // Replace with actual emergency contact
  String ambulanceNumber = "102"; // Replace with actual ambulance number
  String? errorMessage;
  String ?report="https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
  List<EmerContact>?emergencyContacts =[];

  init() async {
    emergencyContacts=   await apiservice.getEmergencyContacts();
    update_emergency_contacts(emergencyContacts);
    notifyListeners();
    report=await apiservice.getmyreport();
    notifyListeners();
  }
  Future<void> shareLocationWithMedicalHistory() async {
    try {
      setBusy(true);
      errorMessage = null;

      // Get current location
      Position position = await _locationService.determinePosition();
      String locationMessage =
          'Emergency! I need help! My current location is:\n'
          '📍 Latitude: ${position.latitude}\n'
          '📍 Longitude: ${position.longitude}\n'
          '🔗 Google Maps: https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}\n\n'
          '📄 Attached: My Trip Details PDF:https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf\n share this file with doctor';

      // Download the Trip DetailsPDF
      File medicalHistoryFile = await _downloadMedicalHistoryPdf(
          '');

      // Share both the PDF file and location message
      await Share.shareXFiles(
        [XFile(medicalHistoryFile.path)],
        text: locationMessage,
      );
    } catch (e) {
      errorMessage = _handleLocationError(e.toString());
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }
  Future<void> shareViaWhatsApp() async {
    try {
      setBusy(true);
      errorMessage = null;

      // Check if emergency contacts exist
      if (emergencyContacts == null || emergencyContacts!.isEmpty) {
        errorMessage = 'No emergency contacts available';
        notifyListeners();
        return;
      }

      // Find the highest priority contact (1 > 2 > 3)
      EmerContact? highestPriorityContact;
      for (var contact in emergencyContacts!) {
        if (contact.priority == "1") {
          highestPriorityContact = contact;
          break;
        } else if (contact.priority == "2" && highestPriorityContact == null) {
          highestPriorityContact = contact;
        } else if (contact.priority == "3" && highestPriorityContact == null) {
          highestPriorityContact = contact;
        }
      }

      if (highestPriorityContact == null) {
        errorMessage = 'No valid emergency contacts found';
        notifyListeners();
        return;
      }

      // Get current location
      Position position = await _locationService.determinePosition();

      // Ensure report URL is properly formatted


      // Compose the message
      String locationMessage =
          '🚑 EMERGENCY ALERT! 🚑\n\n'
          'I need immediate assistance!\n\n'
          '📍 My Current Location:\n'
          'Latitude: ${position.latitude}\n'
          'Longitude: ${position.longitude}\n'
          'Google Maps: https://www.google.com/maps/search/?api=1&query=${position
          .latitude},${position.longitude}\n\n'
          '📄 Trip Details: $report\n\n'
          'Please respond immediately!';

      // Format phone number (remove any non-digit characters)
      String phoneNumber = highestPriorityContact.phone.toString().replaceAll(
          RegExp(r'[^0-9]'), '');

      // Launch WhatsApp
      await launchUrlString(
        "whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent(
            locationMessage)}",
        mode: LaunchMode.externalApplication,
      );
    } on Exception catch (e) {
      errorMessage = 'Failed to share via WhatsApp: ${e.toString()}';
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }
  // Future<void> shareViaWhatsApp() async {
  //   try {
  //     setBusy(true);
  //     errorMessage = null;
  //
  //     // Get current location
  //     Position position = await _locationService.determinePosition();
  //
  //     // Build emergency contacts information
  //     String emergencyContactsInfo = '';
  //     if (emergencyContacts != null && emergencyContacts!.isNotEmpty) {
  //       emergencyContactsInfo = '\n\n🚨 Emergency Contacts:\n';
  //       for (var contact in emergencyContacts!) {
  //         emergencyContactsInfo +=
  //         '👤 ${contact.name} (${contact.relationship}): ${contact.phone}\n';
  //       }
  //     }
  //
  //     String locationMessage =
  //         '🚑 EMERGENCY ALERT! 🚑\n'
  //         'I need immediate assistance!\n\n'
  //         '📍 My Current Location:\n'
  //         'Latitude: ${position.latitude}\n'
  //         'Longitude: ${position.longitude}\n'
  //         'Google Maps: https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}\n\n'
  //         '📄 Medical History: https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf'
  //         '$emergencyContactsInfo';
  //
  //     // Encode the message for WhatsApp URL
  //     String encodedMessage = Uri.encodeComponent(locationMessage);
  //
  //     // Launch WhatsApp with the message
  //     await launchUrlString(
  //       "whatsapp://send?text=$encodedMessage",
  //       mode: LaunchMode.externalApplication,
  //     );
  //   } catch (e) {
  //     errorMessage = _handleLocationError(e.toString());
  //     notifyListeners();
  //   } finally {
  //     setBusy(false);
  //   }
  // }

  Future<void> makeEmergencyCall() async {
    try {
      final Uri url = Uri.parse('tel:$emergencyContact');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch emergency call';
      }
    } catch (e) {
      errorMessage = 'Failed to make emergency call';
      notifyListeners();
    }
  }

  Future<void> callAmbulance() async {
    try {
      final Uri url = Uri.parse('tel:$ambulanceNumber');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch ambulance call';
      }
    } catch (e) {
      errorMessage = 'Failed to call ambulance';
      notifyListeners();
    }
  }
  //
  // Future<void> shareLocationWithMedicalHistory() async {
  //   try {
  //     setBusy(true);
  //     errorMessage = null;
  //
  //     // Get current location
  //     Position position = await _locationService.determinePosition();
  //     String locationMessage =
  //         'Emergency! I need help! My current location is:\n'
  //         '📍 Latitude: ${position.latitude}\n'
  //         '📍 Longitude: ${position.longitude}\n'
  //         '🔗 Google Maps: https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}\n\n'
  //         '📄 Attached: My Trip DetailsPDF:https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf\n share this file with doctor';
  //
  //     // Download the Trip DetailsPDF
  //     File medicalHistoryFile = await _downloadMedicalHistoryPdf(
  //         'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf');
  //
  //     // Share both the PDF file and location message
  //     await Share.share(
  //       locationMessage// Attach location message
  //     );
  //   } catch (e) {
  //     errorMessage = _handleLocationError(e.toString());
  //     notifyListeners();
  //   } finally {
  //     setBusy(false);
  //   }
  // }

// Function to download the PDF
  Future<File> _downloadMedicalHistoryPdf(String url) async {
    final Directory tempDir = await getTemporaryDirectory();
    final String filePath = '${tempDir.path}/medical_history.pdf';
    final File file = File(filePath);

    try {
      Response response = await Dio().download(url, filePath);
      if (response.statusCode == 200) {
        return file;
      } else {
        throw Exception("Failed to download PDF");
      }
    } catch (e) {
      throw Exception("Error downloading PDF: $e");
    }
  }

  String _handleLocationError(String error) {
    if (error.contains('Location services are disabled')) {
      return 'Please enable location services in settings';
    } else if (error.contains('permissions are denied')) {
      return 'Location permission is required';
    } else if (error.contains('permanently denied')) {
      return 'Location permissions are permanently denied. Please enable in settings';
    }
    return 'Failed to get location';
  }

  void openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  void openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  void update_emergency_contacts(List<EmerContact>? emergencyContacts) {
    if (emergencyContacts == null || emergencyContacts.isEmpty) {
      // Keep default values if no contacts are available
      emergencyContact = "911";
      ambulanceNumber = "102";
      return;
    }

    // Sort contacts by priority (ascending order)
    emergencyContacts.sort((a, b) => a.priority!.compareTo(b.priority.toString()));

    // Find the highest priority contact (priority 1, then 2, then 3)
    EmerContact? highestPriorityContact;
    for (var contact in emergencyContacts) {
      if (contact.priority == "1") {
        highestPriorityContact = contact;
        break; // Found highest priority, no need to check others
      } else if (contact.priority == "2" && highestPriorityContact == null) {
        highestPriorityContact = contact;
      } else if (contact.priority == "3" && highestPriorityContact == null) {
        highestPriorityContact = contact;
      }
    }

    // Update emergency contact if found
    if (highestPriorityContact != null) {
      emergencyContact = highestPriorityContact.phone.toString();
      print(emergencyContact);
    }

    // You might want to add similar logic for ambulanceNumber if needed
    // For now, keeping it as default "102"
  }

}

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied';
    }

    return await Geolocator.getCurrentPosition();
  }
}
