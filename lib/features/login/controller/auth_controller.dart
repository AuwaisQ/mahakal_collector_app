// import 'dart:async';
// import 'package:collectorapp/appconstants.dart';
// import 'package:collectorapp/services/httpservice.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../model/login_model.dart';
//
// class AuthController with ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FlutterSecureStorage _storage = FlutterSecureStorage();
//
//   String? _verificationId;
//   bool _isLoading = false;
//   String? _phoneNumber;
//   LoginModel? _loginResponse;
//   bool _isLoggedIn = false;
//   String? _userToken;
//   String? _firebaseUid;
//   String? _type;
//
//   bool get isLoading => _isLoading;
//   String? get phoneNumber => _phoneNumber;
//   LoginModel? get loginResponse => _loginResponse;
//   bool get isLoggedIn => _isLoggedIn;
//   String? get userToken => _userToken;
//   String? get firebaseUid => _firebaseUid;
//   String? get type => _type;
//
//   AuthController() {
//     _checkPersistentLogin();
//   }
//
//   // Check persistent login on startup
//   Future<void> _checkPersistentLogin() async {
//     try {
//       // Check secure storage
//       String? token = await _storage.read(key: 'user_token');
//       String? phone = await _storage.read(key: 'user_phone');
//       String? type = await _storage.read(key: 'type');
//       String? uid = await _storage.read(key: 'firebase_uid');
//
//       // Check Firebase auth
//       User? firebaseUser = _auth.currentUser;
//
//       if (token != null && phone != null && uid != null) {
//         _userToken = token;
//         _phoneNumber = phone;
//         _type = type;
//         _firebaseUid = uid;
//         _isLoggedIn = true;
//
//         // Set login response
//         _loginResponse = LoginModel(
//           status: true,
//           message: 'User logged in',
//           token: token, type: "${type}",
//         );
//
//         print('Persistent login found for: $phone');
//         print('Persistent login Type for: $type');
//       } else {
//         _isLoggedIn = false;
//         print('No persistent login found');
//       }
//
//       notifyListeners();
//     } catch (e) {
//       print('Error checking persistent login: $e');
//       _isLoggedIn = false;
//     }
//   }
//
//   // Save login data to persistent storage
//   Future<void> _saveLoginData(Map<String, dynamic> userData) async {
//     try {
//       await _storage.write(
//         key: 'user_token',
//         value: userData['token']?.toString() ?? '',
//       );
//       await _storage.write(
//         key: 'user_phone',
//         value: userData['phone']?.toString() ?? '',
//       );
//       await _storage.write(
//         key: 'firebase_uid',
//         value: userData['firebase_uid']?.toString() ?? '',
//       );
//       await _storage.write(
//         key: 'type',
//         value: userData['type']?.toString() ?? '',
//       );
//
//       // Update local variables
//       _userToken = userData['token']?.toString();
//       _phoneNumber = userData['phone']?.toString();
//       _firebaseUid = userData['firebase_uid']?.toString();
//       _type = userData['type']?.toString();
//       _isLoggedIn = true;
//
//       print('Login data saved to persistent storage');
//     } catch (e) {
//       print('Error saving login data: $e');
//     }
//   }
//
//   // Check user registration and send OTP
//   Future<Map<String, dynamic>> loginWithPhone(String phoneNumber) async {
//     try {
//       _isLoading = true;
//       notifyListeners();
//
//       String formattedPhone = phoneNumber.startsWith('+') ? phoneNumber : '+91$phoneNumber';
//       print('Checking registration for: $formattedPhone');
//
//       // Call API to check registration
//       final response = await http.post(
//         Uri.parse('${AppConstants.baseUrl}${AppConstants.loginAPI}'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//         body: jsonEncode({'mobile': formattedPhone}),
//       ).timeout(const Duration(seconds: 10));
//
//       print('API Status: ${response.statusCode}');
//       print('API Response: ${response.body}');
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         _loginResponse = LoginModel.fromJson(responseData);
//
//         if (_loginResponse!.status == true) {
//           // User is registered, send Firebase OTP
//           final otpResult = await _sendFirebaseOTP(formattedPhone);
//           print("Sent Otp Result ${otpResult}");
//
//           if (otpResult['success'] == true) {
//             return {
//               'success': true,
//               'registered': true,
//               'message': _loginResponse!.message,
//               'token': _loginResponse!.token,
//             };
//           } else {
//             return otpResult;
//           }
//         } else {
//           return {
//             'success': false,
//             'registered': false,
//             'message': _loginResponse!.message,
//             'token': null,
//           };
//         }
//       } else {
//         return {
//           'success': false,
//           'message': 'Server error: ${response.statusCode}',
//           'registered': null,
//           'token': null,
//         };
//       }
//     } on http.ClientException catch (e) {
//       return {
//         'success': false,
//         'message': 'Network error: ${e.message}',
//         'registered': null,
//         'token': null,
//       };
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   // Send Firebase OTP
//   Future<Map<String, dynamic>> _sendFirebaseOTP(String formattedPhone) async {
//     Completer<Map<String, dynamic>> completer = Completer();
//
//     try {
//       await _auth.verifyPhoneNumber(
//         phoneNumber: formattedPhone,
//         verificationCompleted: (credential) {
//           if (!completer.isCompleted) {
//             completer.complete({
//               'success': true,
//               'message': 'Auto verification completed',
//             });
//           }
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           if (!completer.isCompleted) {
//             completer.complete({
//               'success': false,
//               'message': _getFirebaseErrorMessage(e),
//             });
//           }
//         },
//         codeSent: (verificationId, resendToken) {
//           _verificationId = verificationId;
//           _phoneNumber = formattedPhone;
//
//           if (!completer.isCompleted) {
//             completer.complete({
//               'success': true,
//               'message': 'OTP sent successfully',
//             });
//           }
//         },
//         codeAutoRetrievalTimeout: (verificationId) {
//           _verificationId = verificationId;
//           if (!completer.isCompleted) {
//             completer.complete({
//               'success': true,
//               'message': 'OTP sent (timeout)',
//             });
//           }
//         },
//         timeout: Duration(seconds: 120),
//       );
//
//       return await completer.future.timeout(Duration(seconds: 125));
//     } on FirebaseAuthException catch (e) {
//       return {
//         'success': false,
//         'message': _getFirebaseErrorMessage(e),
//       };
//     } catch (e) {
//       return {
//         'success': false,
//         'message': 'Failed to send OTP: $e',
//       };
//     }
//   }
//
//   // Verify OTP and complete login
//   Future<Map<String, dynamic>> verifyOTP(String otp) async {
//     try {
//       _isLoading = true;
//       notifyListeners();
//
//       if (_verificationId == null || _phoneNumber == null) {
//         return {
//           'success': false,
//           'message': 'Session expired. Please request OTP again.',
//         };
//       }
//
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: _verificationId!,
//         smsCode: otp,
//       );
//
//       UserCredential userCredential = await _auth.signInWithCredential(credential);
//
//       if (userCredential.user != null) {
//         // Save login data
//         Map<String, dynamic> userData = {
//           'token': _loginResponse?.token,
//           'phone': _phoneNumber,
//           'firebase_uid': userCredential.user!.uid,
//           'type': _loginResponse?.type ?? ''
//         };
//
//         await _saveLoginData(userData);
//
//         return {
//           'success': true,
//           'message': 'Login successful',
//           'userData': userData,
//         };
//       }
//
//       return {
//         'success': false,
//         'message': 'Login failed',
//       };
//     } on FirebaseAuthException catch (e) {
//       return {
//         'success': false,
//         'message': _getFirebaseErrorMessage(e),
//       };
//     } catch (e) {
//       return {
//         'success': false,
//         'message': 'Error: $e',
//       };
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   // Resend OTP
//   Future<Map<String, dynamic>> resendOTP() async {
//     try {
//       if (_phoneNumber == null) {
//         return {
//           'success': false,
//           'message': 'Phone number not found',
//         };
//       }
//
//       final checkResult = await loginWithPhone(_phoneNumber!);
//       if (checkResult['success'] == true && checkResult['registered'] == true) {
//         return {
//           'success': true,
//           'message': 'OTP resent successfully',
//         };
//       } else {
//         return checkResult;
//       }
//     } catch (e) {
//       return {
//         'success': false,
//         'message': 'Failed to resend OTP: $e',
//       };
//     }
//   }
//
//   String _getFirebaseErrorMessage(FirebaseAuthException e) {
//     switch (e.code) {
//       case 'invalid-verification-code':
//         return 'Invalid OTP. Please check and try again.';
//       case 'session-expired':
//         return 'OTP expired. Please request a new one.';
//       case 'invalid-phone-number':
//         return 'Invalid phone number format';
//       case 'too-many-requests':
//         return 'Too many attempts. Please try again later.';
//       case 'quota-exceeded':
//         return 'Daily SMS limit reached. Try again tomorrow.';
//       default:
//         return e.message ?? 'Authentication failed';
//     }
//   }
//
//   // Clear session data
//   void clearSession() {
//     _verificationId = null;
//     _phoneNumber = null;
//     _loginResponse = null;
//     notifyListeners();
//   }
//
//   // Logout user
//   Future<void> logout() async {
//     try {
//       // Firebase sign out
//       await _auth.signOut();
//
//       // Clear secure storage
//       await _storage.delete(key: 'user_token');
//       await _storage.delete(key: 'user_phone');
//       await _storage.delete(key: 'firebase_uid');
//       await _storage.delete(key: 'type');
//
//       // Call API using HttpService
//       final res = await HttpService().getApi(AppConstants.logoutAPI);
//       if (res != null) {
//         print('Logout API message: ${res["message"] ?? "No message"}');
//       }
//
//       // Clear local variables
//       _isLoggedIn = false;
//       _userToken = null;
//       _phoneNumber = null;
//       _firebaseUid = null;
//       _loginResponse = null;
//       _verificationId = null;
//       _type = null;
//
//       print('User logged out successfully');
//     } catch (e) {
//       print("Error during logout: $e");
//       // Still clear local data even if API fails
//       _isLoggedIn = false;
//       _userToken = null;
//       _phoneNumber = null;
//       _firebaseUid = null;
//       _loginResponse = null;
//       _verificationId = null;
//       _type = null;
//
//     } finally {
//       notifyListeners();
//     }
//   }
// }

// services/auth_controller.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../../appconstants.dart';
import '../model/login_model.dart';


class AuthController with ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _userToken;
  String? get userToken => _userToken;

  String? _userType;
  String? get userType => _userType;

  LoginModel? _loginResponse;
  LoginModel? get loginResponse => _loginResponse;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  AuthController() {
    _checkPersistentLogin();
  }

  // Check persistent login on startup
  Future<void> _checkPersistentLogin() async {
    try {
      String? token = await _storage.read(key: 'user_token');
      String? mobile = await _storage.read(key: 'user_mobile');
      String? type = await _storage.read(key: 'user_type');

      if (token != null && mobile != null) {
        _userToken = token;
        _isLoggedIn = true;
        _userType = type;
        notifyListeners();
        print('Persistent login found for: $mobile');
      } else {
        _isLoggedIn = false;
        print('No persistent login found');
      }
    } catch (e) {
      _isLoggedIn = false;
      print('Error checking persistent login: $e');
    }
  }

  // Save login data to secure storage
  Future<void> _saveLoginData(Map<String, dynamic> userData) async {
    try {
      await _storage.write(key: 'user_token', value: userData['token'] ?? '');
      await _storage.write(key: 'user_mobile', value: userData['mobile'] ?? '');
      await _storage.write(key: 'user_type', value: userData['type'] ?? '');

      _userToken = userData['token'];
      _userType = userData['type'];
      _isLoggedIn = true;
      notifyListeners();
      print('Login data saved successfully');
    } catch (e) {
      print('Error saving login data: $e');
    }
  }

  // Login with mobile & password
  Future<Map<String, dynamic>> loginWithMobile(
      String mobile, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.loginAPI}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'mobile': mobile,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _loginResponse = LoginModel.fromJson(data);

        if (_loginResponse?.status == true) {
          await _saveLoginData({
            'token': _loginResponse?.token,
            'mobile': mobile,
            'type': _loginResponse?.data?.type,
          });

          return {
            'success': true,
            'message': _loginResponse?.message,
            'token': _loginResponse?.token,
          };
        } else {
          return {
            'success': false,
            'message': _loginResponse?.message ?? 'Login failed',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _storage.delete(key: 'user_token');
      await _storage.delete(key: 'user_mobile');
      _isLoggedIn = false;
      _userToken = null;
      _loginResponse = null;
      notifyListeners();
      print('User logged out successfully');
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}