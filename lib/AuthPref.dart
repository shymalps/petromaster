// import 'package:shared_preferences/shared_preferences.dart';


import 'package:shared_preferences/shared_preferences.dart';

import 'core/utils/debuprint.dart';

class AuthPreferences {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _onOnboardedKey = 'onBoarding';
  static const String _userIdKey = 'userId';
  static const String _rememberedUsernameKey = 'rememberedUsername';
  static const String _stuIdKey = 'stuId';
  static const String _classID = 'classID';
 
  AuthPreferences._();
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    consolePrint('isLoggedIn: ${prefs.getBool(_isLoggedInKey)}');
    return prefs.getBool(_isLoggedInKey) ??
        false; // Default to false if not set
  }

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    consolePrint('isLoggedIn: $value');
    await prefs.setBool(_isLoggedInKey, value);
  }

  static Future<bool> isOnboarded() async {
    final prefs = await SharedPreferences.getInstance();
    consolePrint('isOnboarded: ${prefs.getBool(_onOnboardedKey)}');
    return prefs.getBool(_onOnboardedKey) ??
        false; // Default to false if not set
  }

  static Future<void> setOnboarded(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    consolePrint('isOnboarded: $value');
    await prefs.setBool(_onOnboardedKey, value);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    consolePrint('UserId: ${prefs.getString(_userIdKey)}');
    return prefs.getString(_userIdKey);
  }
  static Future<String?> getstuId() async {
    final prefs = await SharedPreferences.getInstance();
    consolePrint('UserId: ${prefs.getString(_stuIdKey)}');
    return prefs.getString(_stuIdKey);
  }
  static Future<String?> getclassId() async {
    final prefs = await SharedPreferences.getInstance();
    consolePrint('UserId: ${prefs.getString(_classID)}');
    return prefs.getString(_classID);
  }

  static Future<void> setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    consolePrint('UserId: $userId');
    await prefs.setString(_userIdKey, userId);
  }
  static Future<void> setstuId(String stuId) async {
    final prefs = await SharedPreferences.getInstance();
    consolePrint('stuId: $stuId');
    await prefs.setString(_stuIdKey, stuId);
  }
  static Future<void> setclassId(String stuId) async {
    final prefs = await SharedPreferences.getInstance();
    consolePrint('classId: $stuId');
    await prefs.setString(_classID, stuId);
  }

  // static Future<String?> getRememberedname() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_remembername);
  // }

  // static Future<void> setRememberedname(String name) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_remembername, name);
  // }

  // static Future<String?> getRememberedclass() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_rememberclass);
  // }

  // static Future<void> setRememberedclass(String name) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_rememberclass, name);
  // }

  static Future<void> setRememberedUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_rememberedUsernameKey, username);
  }

  static Future<String?> getRememberedUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_rememberedUsernameKey);
  }

  static Future<void> clearRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_rememberedUsernameKey);
  }
  // Add more getters and setters for other user-related data as needed

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
    await prefs.remove(_classID);
    await prefs.remove(_stuIdKey);
    // Optionally, you can clear other user data on logout:
    await prefs.remove(_userIdKey);
    // ... remove other keys as needed
  }
}

// Example Usage in your Flutter application:

// 1. Login:
//   - After successful login:
//     await AuthPreferences.setLoggedIn(true);
//     await AuthPreferences.setUserId('user123');
//     await AuthPreferences.setUserName('John Doe');
//     await AuthPreferences.setUserEmail('john.doe@example.com');

// 2. Check if logged in:
//   - In your main widget or a splash screen:
//     bool isLoggedIn = await AuthPreferences.isLoggedIn();
//     if (isLoggedIn) {
//       // Navigate to home screen
//     } else {
//       // Navigate to login screen
//     }

// 3. Get user data:
//   - In any widget where you need user data:
//     String? userId = await AuthPreferences.getUserId();
//     String? userName = await AuthPreferences.getUserName();
//     String? userEmail = await AuthPreferences.getUserEmail();
//     print('User ID: $userId, Name: $userName, Email: $userEmail');

// 4. Logout:
//   - When the user clicks the logout button:
//     await AuthPreferences.logout();
//     // Navigate to login screen

// 5. Clear all data (use with caution):
//    await AuthPreferences.clearAll();
