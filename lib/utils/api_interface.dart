import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:jk_otm/Screens/auth%20screens/auth_screen.dart';
import 'package:jk_otm/Screens/landing_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> makeRequest({
  required String url,
  required String method,
  dynamic body = const {},
  bool requiresAuth = true,
  required BuildContext context,
}) async {
  try {
    var headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jktyreEtmsS = prefs.getString('jktyre_etms_s');
    String? jktyreEtmsL = prefs.getString('jktyre_etms_l');
    String? cookieSession = prefs.getString('cookiesession1');

    List<String> cookies = [];
    if (cookieSession != null) cookies.add('cookiesession1=$cookieSession');
    cookies.add('jktyre_etms_l=$jktyreEtmsL');
    cookies.add('jktyre_etms_s=$jktyreEtmsS');

    headers['Cookie'] = cookies.join('; ');

    var request = Request(method, Uri.parse(url));

    log("${headers['Cookie']} checking output");

    log('URL: $url');
    log('Method: $method');
    request.headers.addAll(headers);

    if (body != null && body.isNotEmpty) {
      request.body = json.encode(body);
      log('Body: ${json.encode(body)}');
    }

    StreamedResponse response = await request.send();
    final responseBody = await response.stream.bytesToString();

    log('Response Status: ${response.statusCode}');
    log('Response Body: $responseBody');

    // Update cookies if available

    final responseData = json.decode(responseBody);

    if (response.statusCode == 200 || response.statusCode == 201) {
      log("${response.statusCode} success");
      if (response.headers['set-cookie'] != null) {
        await updateCookiesFromHeaders(response.headers);
      }
      return {
        'success': true,
        'data': responseData,
      };
    } else if (response.statusCode == 401) {
      // Clear cookies on unauthorized
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('jktyre_etms_s');
      await prefs.remove('jktyre_etms_l');
      await prefs.remove('cookiesession1');
      await prefs.remove('usrid');

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return AuthScreen();
        },
      ));

      return {
        'success': false,
        'message': 'Session expired',
        'status': 401,
      };
    } else if (response.statusCode == 403) {
      // Call getRolesAndModules and go to LandingScreen

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return LandingScreen();
        },
      ));

      return {
        'success': false,
        'message': 'Session expired',
        'status': 403,
      };
    } else {
      log("Error response: $responseData");
      return {
        'success': false,
        'message': responseData['message'] ?? 'Request failed'
      };
    }
  } catch (e) {
    log('Error: $e');
    return {'success': false, 'message': 'An error occurred'};
  }
}

Future<void> updateCookiesFromHeaders(Map<String, String> headers) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? setCookie = headers['set-cookie'];
  if (setCookie != null) {
    // Parse and extract cookies
    Map<String, String> cookies = _parseCookies(setCookie);

    log("${cookies['jktyre_etms_s']} checking input");
    log("${cookies['jktyre_etms_l']} checking input");

    log("${cookies.containsKey('jktyre_etms_s')} checking input");
    log("${cookies.containsKey('jktyre_etms_l')} checking input");
    log("${cookies.containsKey('cookiesession1')} checking input");

    // Update cookies in SharedPreferences if all three cookies exist

    if (cookies.containsKey('jktyre_etms_s')) {
      await prefs.setString('jktyre_etms_s', cookies['jktyre_etms_s']!);
    }
    if (cookies.containsKey('jktyre_etms_l')) {
      await prefs.setString('jktyre_etms_l', cookies['jktyre_etms_l']!);
    }
    if (cookies.containsKey('cookiesession1')) {
      await prefs.setString('cookiesession1', cookies['cookiesession1']!);
    }
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

void showErrorToast(String message) {
  EasyLoading.showToast(message, maskType: EasyLoadingMaskType.black);
}

void showSuccessToast(String message) {
  EasyLoading.showToast(message, maskType: EasyLoadingMaskType.black);
}
