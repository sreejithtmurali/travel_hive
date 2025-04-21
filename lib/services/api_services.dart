import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:my_travelmate/app/utils.dart';
import 'package:my_travelmate/models/Tripres.dart';

import 'package:my_travelmate/models/mytrips/Data.dart';
import 'package:my_travelmate/models/mytrips/MytripsResModelDart.dart';
import 'package:my_travelmate/models/profileupdate/Data.dart';
import 'package:my_travelmate/models/profileupdate/ProfileUpdateResp.dart';
import 'package:my_travelmate/models/roomres/RoomsRes.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../models/chat/ChatMessage.dart';
import '../models/getallemergency/Data.dart';
import '../models/getallemergency/EmergencyContacts.dart';
import '../models/login/LoginResModel.dart';

class ApiService {
  // Select the environment (Change this to prod for production)
  static final ApiEnvironment currentEnv = ApiEnvironment.dev;

  // Use the selected environment's base URL
  static final String baseUrl = currentEnv.baseUrl;
  Future<String?> getToken() async {
    return await userservice.getUserField("access");
  }

// =============================================================================================================
// Registartion(POST)
  Future<bool?> onRegister(
      String name, String phone, String email, String password) async {
    final url = Uri.parse("$baseUrl/registration/");
    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json"
    };
    var body = jsonEncode({
      "name": name,
      "phone": phone,
      "email": email,
      "password": password,
    });
    print("headers:$headers:::body::$body,url::$url");
    try {
      //SmartDialog.showLoading();
      final response = await http.post(url, headers: headers, body: body);
      //SmartDialog.dismiss();
      print(response.body);
      print(response.statusCode);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        print(response.body);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      //SmartDialog.dismiss();
      print(e.toString());
      return false;
    }
  }

  Future<LoginResModel?> onLogin(String email, String password) async {
    final url = Uri.parse("$baseUrl/login/");
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };
    var body = jsonEncode({
      "email": email,
      "password": password,
    });

    print("Request -> URL: $url, Headers: $headers, Body: $body");

    try {
      //SmartDialog.showLoading();
      final response = await http.post(url, headers: headers, body: body);
      //SmartDialog.dismiss();

      print(
          "Response -> Status Code: ${response.statusCode}, Body: ${response.body}");

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var res = LoginResModel.fromJson(jsonResponse);
        return res;
      } else {
        print("Login failed: ${response.body}");
      }
    } catch (e) {
      print("Login Error: $e");
    } finally {
      //SmartDialog.dismiss(); // Ensure dismissal on any error
    }
    return null;
  }

// ================================================================================================================

  // Plan my trip(Multi part POST)

  Future<dynamic> getProfile() async {
    print("Initiating Create Trip multipart request...");
    String? accessToken = await getToken();

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception("User is not authenticated. Access token is missing.");
    }
    var headers = {
      "accept": "application/json",
      "Authorization": "Bearer $accessToken",
    };
    try {
      var uri = Uri.parse("$baseUrl/profile/");
      print("headers:$headers::url::$uri");

      var response = await http.get(uri, headers: headers);
      print(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {}
      // Show loading indicator
    } catch (e) {}
  }
  // =====================================================================================================

  // To List myTrip in my trip screen (Get)
  Future<List<MyTrip>?> fetchMyTrip() async {
    final url = Uri.parse("$baseUrl/my-trips/");
    String? accessToken = await getToken();

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception("User is not authenticated. Access token is missing.");
    }

    var headers = {
      "accept": "application/json",
      "Authorization": "Bearer $accessToken",
    };

    try {
      print("Fetching trips from: $url");
      final response = await http.get(url, headers: headers);

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var jsonData = json.decode(response.body);
        var res = MytripsResModelDart.fromJson(jsonData);
        var list = res.data;
        return list;
      } else {
        throw Exception("Invalid response format: 'data' key missing or null");
      }
    } catch (e) {
      print("Error fetching trips: $e");
      throw Exception("Error fetching trips: $e");
    }
  }
  // =======================================================================================================================

  // fetching the ath trip from backend to the HomeScrenn including the trip hosted by the user(GET)

  Future<List<MyTrip>?> fetchUpComingTrips() async {
    final url = Uri.parse("$baseUrl/trip-all/");
    String? accessToken = await getToken();

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception("User is not authenticated. Access token is missing.");
    }

    var headers = {
      "accept": "application/json",
      "Authorization": "Bearer $accessToken",
    };

    try {
      print("Fetching trips from: $url");
      final response = await http.get(url, headers: headers);

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var jsonData = json.decode(response.body);
        var res = MytripsResModelDart.fromJson(jsonData);
        var list = res.data;
        return list;
      } else {
        throw Exception("Invalid response format: 'data' key missing or null");
      }
    } catch (e) {
      print("Error fetching trips: $e");
      throw Exception("Error fetching trips: $e");
    }
  }

// ============================================================================================================

// To POST the profile to the database(MultiPartPut request)

  Future<Data?> postProfileDetails({
    required String name,
    required String phone,
    required String email,
    required String alternativePhone,
    File? image,
    required String travelType,
    required String language,
    File? idProof,
    required String budget,
    required String groupSize,
    required String fromDate,
    required String toDate,
  }) async {
    print("Initiating Profile Details multipart request...");
    String? accessToken = await getToken();

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception("User is not authenticated. Access token is missing.");
    }
    var headers = {
      "accept": "application/json",
      "Authorization": "Bearer $accessToken",
    };
    print(headers);
    try {
      var uri = Uri.parse("$baseUrl/profile-update/");
      print(uri);
      // Show loading indicator
      //SmartDialog.showLoading(msg: "Updating profile...");

      var request = http.MultipartRequest("PUT", uri)..headers.addAll(headers);

      // Add form fields
      request.fields['name'] = name;
      request.fields['phone'] = phone;
      request.fields['email'] = email;
      request.fields['alternative_phone'] = alternativePhone;
      request.fields['travel_type'] = travelType;
      request.fields['language'] = language;
      request.fields['budget'] = budget;
      request.fields['group_size'] = groupSize;
      request.fields['from_date'] = fromDate;
      request.fields['to_date'] = toDate;

      // Attach image if available
      if (image != null) {
        final mimeType = lookupMimeType(image.path) ?? 'image/jpeg';
        print("📷 Attaching profile image of type: $mimeType");

        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            image.path,
            contentType: MediaType.parse(mimeType),
          ),
        );
      }

      // Attach ID proof if available
      if (idProof != null) {
        final mimeType = lookupMimeType(idProof.path) ?? 'image/jpeg';
        print("📷 Attaching ID proof image of type: $mimeType");

        request.files.add(
          await http.MultipartFile.fromPath(
            'id_proof',
            idProof.path,
            contentType: MediaType.parse(mimeType),
          ),
        );
      }

      print("Sending request with fields: \${request.fields}");

      // Send request and await response
      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();

      // Always dismiss loading dialog, regardless of outcome
      // SmartDialog.dismiss();

      if (streamedResponse.statusCode >= 200 &&
          streamedResponse.statusCode < 300) {
        print("Profile updated successfully: $responseBody");
        var json = jsonDecode(responseBody);
        var res = ProfileUpdateResp.fromJson(json);
        return res.data;
      } else {
        print(
            "Failed to update profile. Status: \${streamedResponse.statusCode}, Response: $responseBody");
      }
    } catch (e, stackTrace) {
      print("Error updating profile: $e");
      print("Stack trace: $stackTrace");
      //SmartDialog.dismiss();
    }
    return null;
  }

  void jointrip(int id) {}
  //==========================================================createtrip
  //  fields=['id','trip_name','location','description',
  //  'travel_type','group_size','budget','from_date','to_date','image']
  Future<bool> createtrip({
    required String trip_name,
    required String description,
    required String location,
    File? image,
    required String travel_type,
    required String budget,
    required String group_size,
    required String from_date,
    required String to_date,
  }) async {
    print("Initiating Profile Details multipart request...");
    String? accessToken = await getToken();

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception("User is not authenticated. Access token is missing.");
    }
    var headers = {
      "accept": "application/json",
      "Authorization": "Bearer $accessToken",
    };
    print(headers);
    try {
      var uri = Uri.parse("$baseUrl/trip-create/");

      // Show loading indicator
      //SmartDialog.showLoading(msg: "Updating profile...");

      var request = http.MultipartRequest("POST", uri)..headers.addAll(headers);

      // Add form fields
      request.fields['trip_name'] = trip_name;
      request.fields['description'] = description;
      request.fields['location'] = location;
      request.fields['location'] = location;
      request.fields['travel_type'] = travel_type;
      request.fields['budget'] = budget;
      request.fields['group_size'] = group_size;
      request.fields['from_date'] = from_date;
      request.fields['to_date'] = to_date;

      // Attach image if available
      if (image != null) {
        final mimeType = lookupMimeType(image.path) ?? 'image/jpeg';
        print("📷 Attaching trip-create image of type: $mimeType");

        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            image.path,
            contentType: MediaType.parse(mimeType),
          ),
        );
      }



      print("Sending request with fields: ${request.fields}");

      // Send request and await response
      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();

      print(responseBody);
      // Always dismiss loading dialog, regardless of outcome
      // SmartDialog.dismiss();

      if (streamedResponse.statusCode >= 200 &&
          streamedResponse.statusCode < 300) {
        print("trip-create Uploaded successfully: $responseBody");
        return true;
      } else {
        print(
            "Failed to create trip-create. Status: \${streamedResponse.statusCode}, Response: $responseBody");
        return false;
      }
    } catch (e, stackTrace) {
      print("Error updating trip-create: $e");
      print("Stack trace: $stackTrace");
      //SmartDialog.dismiss();
      return false;
    }
  }

  Future<bool> addEmergencyContact(
      {required String name,
      required String relationship,
      required String phone,
      required String email,
      required int priority}) async {
    Uri url = Uri.parse("$baseUrl/contact/");

    var body = jsonEncode({
      "name": name,
      "relationship": relationship,
      "phone": phone,
      "email": email,
      "priority": priority
    });

    String? accessToken = await getToken();

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception("User is not authenticated. Access token is missing.");
    }

    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    print("URL: $url\nBody: $body\nHeaders: $headers");

    try {
      final response = await http.post(url, body: body, headers: headers);
      print("Response: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return true;
      } else {
        print(
            "Error adding emergency contact: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      print("Exception adding emergency contact: $e");
      return false;
    }
  }

  Future<List<EmerContact>?> getEmergencyContacts() async {
    Uri url = Uri.parse("$baseUrl/contact/");

    String? accessToken = await getToken();

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception("User is not authenticated. Access token is missing.");
    }

    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    print("URL: $url\nHeaders: $headers");

    try {
      final response = await http.get(url, headers: headers);
      print("Response : ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var json = jsonDecode(response.body);
        var res = EmergencyContacts.fromJson(json);
        var list = res.data;
        return list;
      } else {
        print(
            "Error getting emergency contacts: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception getting emergency contacts: $e");
      return null;
    }
  }

  Future<String?> getmyreport() async {
    try {
      final url = Uri.parse('$baseUrl/report/');
      String? accessToken = await getToken();

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception("User is not authenticated. Access token is missing.");
      }

      var headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      };
      // Prepare request body
      print(" report URL: $url\n\nHeaders: $headers");

      // Send POST request
      final response = await http.get(
        url,
        headers: headers,
      );
      print("pdf::${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful booking
        var json = jsonDecode(response.body);
        var res=Tripres.fromJson(json);
         return res.data;
      } else {
        debugPrint(
            'report failed. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error in report API call: $e');
    }
    return null;
  }

  Future<bool> deleteEmergencyContact({required int contactId}) async {
    Uri url = Uri.parse("$baseUrl/contact/$contactId/");
    String? accessToken = await getToken();

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception("User is not authenticated. Access token is missing.");
    }

    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    print("URL: $url\nHeaders: $headers");

    try {
      final response = await http.delete(url, headers: headers);
      print("Response: ${response.statusCode} - ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        print("Successfully deleted emergency contact with ID: $contactId");
        return true;
      } else {
        print(
            "Error deleting emergency contact: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      print("Exception deleting emergency contact: $e");
      return false;
    }
  }

  Future<bool> updatetrip({
    required num id,
    required String trip_name,
    required String description,
    required String location,
    File? image,
    required String travel_type,
    required String budget,
    required String group_size,
    required String from_date,
    required String to_date,
  }) async {
    print("Initiating Profile Details multipart request...");
    String? accessToken = await getToken();

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception("User is not authenticated. Access token is missing.");
    }
    var headers = {
      "accept": "application/json",
      "Authorization": "Bearer $accessToken",
    };
    print(headers);
    try {
      var uri = Uri.parse("$baseUrl/trip-update/$id/");

      // Show loading indicator
      //SmartDialog.showLoading(msg: "Updating profile...");

      var request = http.MultipartRequest("PUT", uri)..headers.addAll(headers);

      // Add form fields
      request.fields['trip_name'] = trip_name;
      request.fields['description'] = description;
      request.fields['location'] = location;
      request.fields['location'] = location;
      request.fields['travel_type'] = travel_type;
      request.fields['budget'] = budget;
      request.fields['group_size'] = group_size;
      request.fields['from_date'] = from_date;
      request.fields['to_date'] = to_date;

      // Attach image if available
      if (image != null) {
        final mimeType = lookupMimeType(image.path) ?? 'image/jpeg';
        print("📷 Attaching trip-create image of type: $mimeType");

        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            image.path,
            contentType: MediaType.parse(mimeType),
          ),
        );
      }



      print("Sending request with fields: ${request.fields}");

      // Send request and await response
      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();

      print(responseBody);
      // Always dismiss loading dialog, regardless of outcome
      // SmartDialog.dismiss();

      if (streamedResponse.statusCode >= 200 &&
          streamedResponse.statusCode < 300) {
        print("trip-create Uploaded successfully: $responseBody");
        return true;
      } else {
        print(
            "Failed to create trip-create. Status: \${streamedResponse.statusCode}, Response: $responseBody");
        return false;
      }
    } catch (e, stackTrace) {
      print("Error updating trip-create: $e");
      print("Stack trace: $stackTrace");
      //SmartDialog.dismiss();
      return false;
    }
  }

  Future<List<RoomsRes>?> getRooms() async {
    try {
      final url = Uri.parse('$baseUrl/api/rooms/');
      String? accessToken = await getToken();

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception("User is not authenticated. Access token is missing.");
      }

      var headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      };
      // Prepare request body
      print(" report URL: $url\n\nHeaders: $headers");

      // Send POST request
      final response = await http.get(
        url,
        headers: headers,
      );
      print("roooms::${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful booking
        List json = jsonDecode(response.body);
        var res=json.map((m){
         return RoomsRes.fromJson(m);
        }).toList();

        return res;
      } else {
        debugPrint(
            'roooms failed. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      debugPrint('roooms in report API call: $e');
    }
    return null;
  }
// ==========================================================================================================================

  Future<RoomsRes> getRoomDetails(num roomId) async {
    try {
      final url = Uri.parse('$baseUrl/api/rooms/$roomId/');
      String? accessToken = await getToken();

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception("User is not authenticated. Access token is missing.");
      }

      var headers = {
        "accept": "application/json",
        "Authorization": "Bearer $accessToken",
      };

      final response = await http.get(url, headers: headers);
      print("Room Details Response: ${response.body}");

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return RoomsRes.fromJson(json);
      } else {
        throw Exception(
            'Failed to fetch room details. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching room details: $e');
      throw Exception('Error fetching room details: $e');
    }
  }

  Future<List<ChatMessage>> getChatMessages({required num roomId}) async {
    try {
      final url = Uri.parse('$baseUrl/api/messages/?room_id=$roomId');
      String? accessToken = await getToken();

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception("User is not authenticated. Access token is missing.");
      }

      var headers = {
        "accept": "application/json",
        "Authorization": "Bearer $accessToken",
      };

      final response = await http.get(url, headers: headers);
      print("Chat Messages Response: ${response.body}");

      if (response.statusCode == 200) {
        List json = jsonDecode(response.body);
        return json.map((m) => ChatMessage.fromJson(m)).toList();
      } else {
        throw Exception(
            'Failed to fetch messages. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }
  Future<bool> sendChatMessage(ChatMessage message, num roomId) async {
    try {
      final url = Uri.parse('$baseUrl/api/messages/send_message/?room_id=$roomId');
      String? accessToken = await getToken();

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception("User is not authenticated. Access token is missing.");
      }

      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      };

      var body = jsonEncode({
        "content": message.content,
      });

      final response = await http
          .post(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 10));

      print("Send Message Response [${response.statusCode}]: ${response.body}");

      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e, stackTrace) {
      print('Error sending message: $e');
      print('StackTrace: $stackTrace');
      return false;
    }
  }
///api/rooms/1/members/add/

  Future<bool> joingroup(num roomId) async {
    try {
      final url = Uri.parse('$baseUrl/api/rooms/$roomId/members/add/');
      String? accessToken = await getToken();

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception("User is not authenticated. Access token is missing.");
      }

      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      };



      final response = await http
          .post(url, headers: headers)
          .timeout(const Duration(seconds: 10));

      print("Join Group Response [${response.statusCode}]: ${response.body}");

      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e, stackTrace) {
      print('Error sending message: $e');
      print('StackTrace: $stackTrace');
      return false;
    }
  }

}

enum ApiEnvironment {
  dev("http://192.168.1.35:8000"), // Development Server
  prod("http://192.168.1.35:8000"); // Production Server

  const ApiEnvironment(this.baseUrl);

  final String baseUrl;
}
