import 'package:shared_preferences/shared_preferences.dart';
import '../models/login/LoginResModel.dart';
// Assuming the model is in a separate file

class UserService {
  // Singleton pattern
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  // SharedPreferences keys
  static const String _userKey = 'user_data';

  // Save user data to SharedPreferences
  Future<void> saveUser(LoginResModel user) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userJson = loginResModelToJson(user);
      await prefs.setString(_userKey, userJson);
    } catch (e) {
      print('Error saving user: $e');
      throw Exception('Failed to save user data');
    }
  }

  // Get user data from SharedPreferences
  Future<LoginResModel?> getUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString(_userKey);

      if (userJson != null) {
        return loginResModelFromJson(userJson);
      }
      return null;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_userKey);
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }

  // Update specific user fields
  Future<void> updateUserField(String field, dynamic value) async {
    try {
      LoginResModel? currentUser = await getUser();
      if (currentUser != null) {
        final Map<String, dynamic> userMap = currentUser.toJson();
        userMap[field] = value;
        final updatedUser = LoginResModel.fromJson(userMap);
        await saveUser(updatedUser);
      }
    } catch (e) {
      print('Error updating user field: $e');
      throw Exception('Failed to update user data');
    }
  }

  // Clear user data (logout)
  Future<void> clearUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
    } catch (e) {
      print('Error clearing user: $e');
      throw Exception('Failed to clear user data');
    }
  }

  // Get specific user field
  Future<dynamic> getUserField(String field) async {
    try {
      LoginResModel? user = await getUser();
      if (user != null) {
        final Map<String, dynamic> userMap = user.toJson();
        return userMap[field];
      }
      return null;
    } catch (e) {
      print('Error getting user field: $e');
      return null;
    }
  }
}