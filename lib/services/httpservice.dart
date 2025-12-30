import 'dart:convert';
import 'dart:io';
import 'package:collectorapp/features/login/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../appconstants.dart';
import '../features/login/controller/auth_controller.dart';

class HttpService {

  Future<dynamic> postApi(String uri, Object map) async {
    try {
      final context = Get.context;
      if (context == null) throw Exception('No valid context found');

      final String userToken = Provider.of<AuthController>(context, listen: false).loginResponse!.token;
      final String fullUrl = AppConstants.baseUrl + uri;

      print('POST API URL: $fullUrl');
      print('Request Body: $map');

      final response = await http.post(
        Uri.parse(fullUrl),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Connection': 'keep-alive',
        },
        body: jsonEncode(map),
      ).timeout(const Duration(seconds: 15));

      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return result;
      } else if (response.statusCode == 401) {
        // Optional: Handle unauthorized access
        print('Unauthorized. Token may be expired.');
        await Provider.of<AuthController>(context, listen: false).logout();
        Provider.of<AuthController>(context, listen: false).clearSession();
        Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
        );
      } else {
        print("Failed API Response: ${response.body}");
      }
    } on SocketException catch (e) {
      print("SocketException: ${e.message}");
    } on HttpException catch (e) {
      print("HttpException: ${e.message}");
    } on FormatException catch (e) {
      print("FormatException: ${e.message}");
    } catch (e) {
      print("Unexpected error in postApi: $e");
    }

    return null; // return null on error
  }

  Future<dynamic> getApi(String uri) async {
    try {
      final context = Get.context;
      if (context == null) throw Exception("No valid context found");

      String userToken = Provider.of<AuthController>(context, listen: false).loginResponse!.token;
      final fullUrl = AppConstants.baseUrl + uri;

      print("API URL: $fullUrl");
      print("User Token: $userToken");

      final response = await http.get(
        Uri.parse(fullUrl),
        headers: {
          'Authorization': 'Bearer $userToken',
        },
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        await Provider.of<AuthController>(context, listen: false).logout();
        Provider.of<AuthController>(context, listen: false).clearSession();
        Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
        );
        return null;
      } else {
        print("Unexpected Status Code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error in getApi: $e");
      return null;
    }
  }

  Future deleteApi(String uri) async {
    print("API URL:${AppConstants.baseUrl + uri}");
    var res = await http.delete(Uri.parse(AppConstants.baseUrl + uri));
    if (res.statusCode == 200) {
      var result = json.decode(res.body);
      return result;
    } else {
      print("delete api Failed Api Response");
    }
  }
}

