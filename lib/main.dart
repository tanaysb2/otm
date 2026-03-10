import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jk_otm/Providers/auth_provider.dart';
import 'package:jk_otm/Providers/transporter_provider.dart';
import 'package:jk_otm/Screens/auth%20screens/auth_screen.dart';
import 'package:jk_otm/Screens/landing_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.hourGlass
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => TransporterProvider()),
      ],
      child: ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: NavigationScreen(),
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
          );
        },
        designSize: const Size(720, 1280),
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<NavigationScreen> {
  void navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? jktyreEtmsS = prefs.getString('jktyre_etms_s');
    String? jktyreEtmsL = prefs.getString('jktyre_etms_l');

    log('$jktyreEtmsS sapppp');
    log('$jktyreEtmsL sapppp');

    // If both cookies exist, navigate to landing page

    if (jktyreEtmsS != null && jktyreEtmsL != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LandingScreen(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AuthScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    navigationPage();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

