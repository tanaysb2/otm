import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jk_otm/utils/api_interface.dart';
import 'package:jk_otm/Screens/auth%20screens/auth_screen.dart';
import 'package:jk_otm/Screens/landing_screen.dart';
import 'package:jk_otm/Urls/url_holder.dart';
import 'package:jk_otm/models/user_role_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  UserRoleResponse? userRoleResponse;
  String user = "";

  Future<bool> login(
      String userId, String password, BuildContext context) async {
    final response = await post(
      Uri.parse('${UrlHolderLoan.baseUrl}${UrlHolderLoan.login}'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userId': userId,
        'password': password,
      }),
    );

    // log('Response Status: ${response.statusCode}');

    // Get Set-Cookie header
    String? setCookie = response.headers['set-cookie'];

    if (setCookie != null) {
      // log('📥 Set-Cookie Header: $setCookie');

      // Parse and extract cookies
      Map<String, String> cookies = _parseCookies(setCookie);

      // log('🍪 Parsed Cookies:');
      cookies.forEach((name, value) {
        // log('   $name: $value');
      });

      // Save cookies to SharedPreferences
      await _saveCookies(cookies);
    } else {
      // log('⚠️ No Set-Cookie header found');
    }

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      log('responseBody $responseBody');
      log('responseBody ${responseBody["data"]["userId"]}');

      if (responseBody['data']['userId'] != null) {
        await prefs.setString('usrid', responseBody["data"]['userId']);
        user = responseBody["data"]["userId"];
      }
      notifyListeners();
      return true;
    } else if (response.statusCode == 401) {
      // Clear cookies and go to login screen
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('jktyre_etms_s');
      await prefs.remove('jktyre_etms_l');
      await prefs.remove('cookiesession1');
      await prefs.remove('usrid');
      notifyListeners();

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return AuthScreen();
        },
      ));

      return false;
    } else if (response.statusCode == 403) {
      // Call getRolesAndModules and go to LandingScreen

      notifyListeners();

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return LandingScreen();
        },
      ));

      return false;
    } else {
      return false;
    }
  }

  Future<void> _saveCookies(Map<String, String> cookies) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (cookies.containsKey('jktyre_etms_s')) {
      await prefs.setString('jktyre_etms_s', cookies['jktyre_etms_s']!);
      log('✅ Saved jktyre_etms_s: ${cookies['jktyre_etms_s']}');
    }

    if (cookies.containsKey('jktyre_etms_l')) {
      await prefs.setString('jktyre_etms_l', cookies['jktyre_etms_l']!);
      log('✅ Saved jktyre_etms_l: ${cookies['jktyre_etms_l']}');
    }

    if (cookies.containsKey('cookiesession1')) {
      await prefs.setString('cookiesession1', cookies['cookiesession1']!);
      log('✅ Saved cookiesession1: ${cookies['cookiesession1']}');
    }
  }

  Map<String, String> _parseCookies(String setCookieHeader) {
    Map<String, String> cookies = {};

    // Split by comma, but be careful with dates
    List<String> parts = setCookieHeader.split(',');
    List<String> cookieStrings = [];
    String tempCookie = '';

    for (String part in parts) {
      if (tempCookie.isEmpty) {
        tempCookie = part;
      } else if (part.trim().contains('=') &&
          (part.trim().startsWith('jktyre_') ||
              part.trim().startsWith('cookiesession'))) {
        cookieStrings.add(tempCookie);
        tempCookie = part;
      } else {
        tempCookie += ',$part';
      }
    }

    if (tempCookie.isNotEmpty) {
      cookieStrings.add(tempCookie);
    }

    // Extract cookie name and value
    for (String cookieString in cookieStrings) {
      List<String> attributes = cookieString.split(';');
      if (attributes.isEmpty) continue;

      List<String> nameValue = attributes[0].split('=');
      if (nameValue.length == 2) {
        String name = nameValue[0].trim();
        String value = nameValue[1].trim();
        cookies[name] = value;
      }
    }

    return cookies;
  }

  Future getRolesAndModules(BuildContext context) async {
    final url = '${UrlHolderLoan.baseUrl}${UrlHolderLoan.rolesAndModules}';
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await makeRequest(
      url: url,
      method: 'GET',
      requiresAuth: true,
      context: context,
    );

    if (response['success'] == true && response['data'] != null) {
      log('${response['data']}✅ Roles and modules fetched successfully');
      // Parse UserRoleResponse from response['data']
      try {
        // If response['data'] is already a parsed dynamic object (as per your API),
        // pass as Map<String, dynamic> to UserRoleResponse.fromJson.
        final txUserRoleResponse = UserRoleResponse.fromJson({
          'success': response['success'],
          'message': response['data']['message'] ?? '',
          'data': response['data']['data']
        });

        user = prefs.getString('usrid') ?? "";

        // Filter to show only items with code "TP"
        final filteredRoles =
            txUserRoleResponse.data.where((role) => role.code == "TP").toList();

        // Filter modules within TP role to only show OPENIND, ASGNTRK, and ALLIND
        final allowedModuleCodes = ["OPENIND", "ASGNTRK", "ALLIND"];
        final filteredData = filteredRoles.map((role) {
          final filteredModules = role.modules
              .where((module) => allowedModuleCodes.contains(module.code))
              .toList();

          return UserRoleModel(
            code: role.code,
            description: role.description,
            modules: filteredModules,
          );
        }).toList();

        userRoleResponse = UserRoleResponse(
          success: txUserRoleResponse.success,
          message: txUserRoleResponse.message,
          data: filteredData,
        );
        notifyListeners();
      } catch (e) {
        log('❌ Error parsing user roles: $e');
        return null;
      }
    } else {
      log('❌ Failed to fetch roles and modules: ${response['message']}');
      return null;
    }
  }

  Future<void> updateCookiesFromResponse(Response response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? setCookie = response.headers['set-cookie'];
    if (setCookie != null) {
      // Parse and extract cookies
      Map<String, String> cookies = _parseCookies(setCookie);

      // Update cookies in SharedPreferences if all three cookies exist
      if (cookies.containsKey('jktyre_etms_s') &&
          cookies.containsKey('jktyre_etms_l') &&
          cookies.containsKey('cookiesession1')) {
        await prefs.setString('jktyre_etms_s', cookies['jktyre_etms_s']!);
        await prefs.setString('jktyre_etms_l', cookies['jktyre_etms_l']!);
        await prefs.setString('cookiesession1', cookies['cookiesession1']!);
        log('✅ Updated all cookies in prefs');
      }
    }
  }

  Future<bool> logout(BuildContext context) async {
    final url = '${UrlHolderLoan.baseUrl}${UrlHolderLoan.logout}';

    final response = await makeRequest(
      url: url,
      method: 'GET',
      requiresAuth: true,
      context: context,
    );

    if (response['success'] == true) {
      log('✅ Logout successful');

      // Clear all stored data
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('jktyre_etms_s');
      await prefs.remove('jktyre_etms_l');
      await prefs.remove('cookiesession1');
      await prefs.remove('usrid');

      // Clear user data
      user = "";
      userRoleResponse = null;
      notifyListeners();

      // Navigate to login screen
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ),
        (route) => false,
      );

      return true;
    } else {
      log('❌ Logout failed: ${response['message']}');
      return false;
    }
  }
}
