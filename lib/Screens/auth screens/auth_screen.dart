import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jk_otm/Reusable%20components/loading.dart';
import 'package:jk_otm/Reusable%20components/text_field.dart';
import 'package:jk_otm/Screens/landing_screen.dart';
import 'package:jk_otm/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn_connection_detector/vpn_connection_detector.dart';

import '../../Providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String email = "";
  String password = "";
  String otp = "";
  var focusNode = FocusNode();
  bool enter = false;
  late StreamSubscription<ConnectivityResult> subscription;

  bool errorShow = false;
  final vpnDetector = VpnConnectionDetector();

  @override
  void initState() {
    super.initState();
  }

// save

  Future logintodashboard() async {
    if (_formKey.currentState!.validate() == true) {
      _formKey.currentState!.save();

      setState(() {
        _isLoading = true;
      });
      Provider.of<AuthProvider>(context, listen: false)
          .login(email, password, context)
          .then((value) async {
        setState(() {
          _isLoading = false;
        });
        if (value == true) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LandingScreen()));
        } else {}
      }).onError((error, stackTrace) {});
    } else {
      return;
    }
  }

  /// save end
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return errorShow
        ? Scaffold(
            backgroundColor: Colors.grey.shade400,
            body: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Text("No Connection Please try again",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 34.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 30.h),
                  Icon(Icons.signal_wifi_connected_no_internet_4),
                  SizedBox(height: 30.h),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Retry",
                        style: TextStyle(color: Colors.white, fontSize: 32.sp)),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.logout, color: Colors.white),
                    color: Colors.white,
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.clear();
                      if (context.mounted) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) {
                              return MyApp();
                            },
                          ),
                          (route) => false,
                        );
                      }
                    },
                  ),
                ],
              ),
            ))
        : Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomCenter,
                  //     colors: <Color>[
                  //       Color.fromARGB(255, 143, 182, 240),
                  //       Color.fromARGB(255, 3, 38, 91),
                  //       Color.fromARGB(255, 3, 38, 91),
                  //     ]),
                  image: DecorationImage(
                    image: AssetImage("assets/backgroundimage.jpg"), // or .jpg
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Container(
                        height: 670.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        margin: EdgeInsets.only(
                            top: 280.h, left: 40.w, right: 40.w),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 47, 78, 72),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color.fromARGB(255, 47, 78, 72),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // SizedBox(height: height * 0.13),
                            // SizedBox(height: height * 0.1),

                            // SizedBox(height: 20.h),

                            Image.asset(
                              "assets/jk.jpeg",
                              height: 130.h,
                              width: 340.w,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(height: 30.h),

                            Text(
                              "Transportation and Global\n      Trade Management",
                              style: TextStyle(
                                  color: Color(0xffFFEB00),
                                  fontFamily: "NotoSans",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30.sp),
                            ),

                            SizedBox(height: 30.h),

                            TextFormField(
                              obscureText: false,
                              cursorColor: Colors.black,
                              onSaved: (newValue) {
                                email = newValue.toString();
                                setState(() {});
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Employee code can't be empty";
                                } else {
                                  return null;
                                }
                              },
                              style: TextStyle(
                                  color: Colors.black, fontSize: 32.sp),
                              decoration: InputDecoration(
                                  filled: true,
                                  isDense: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                  hintText: "Enter Username",
                                  hintStyle: textFieldStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 28.sp)),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),

                            SizedBox(height: height * 0.02),

                            Padding(
                              padding: EdgeInsets.zero,
                              child: TextFormField(
                                obscureText: true,
                                cursorColor: Color.fromARGB(255, 3, 38, 91),
                                onSaved: (newValue) {
                                  password = newValue.toString();
                                  setState(() {});
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Employee code can't be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                style: TextStyle(
                                    color: Colors.black, fontSize: 32.sp),
                                decoration: InputDecoration(
                                    filled: true,
                                    isDense: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                    color: Colors.white, width: 2),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                    hintText: "Enter Password",
                                    hintStyle: textFieldStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 28.sp)),
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                    ),
                            ),
                            SizedBox(height: 40.h),
                            SizedBox(
                              width: double.infinity,
                              height: 70.h,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffFFEB00),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          8), // <-- Radius
                                    ),
                                  ),
                                  onPressed: () {
                                    logintodashboard();
                                  },
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "NotoSans",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  )),
                            ),
                            SizedBox(height: 40.h),

                            // Container(
                            //   alignment: Alignment.center,
                            //   child: Text(
                            //     "Version 62",
                            //     style: TextStyle(
                            //         color: Color.fromARGB(255, 19, 77, 163),
                            //         fontFamily: "NotoSans",
                            //         fontWeight: FontWeight.w600,
                            //         fontSize: 19),
                            //   ),
                            // ),
                            // SizedBox(height: 40.h),

                            // Container(
                            //   alignment: Alignment.center,
                            //   child: Text(
                            //     "JKTyre copyright @All Right Resevered 2023",
                            //     style: TextStyle(
                            //         color: Colors.black,
                            //         fontFamily: "NotoSans",
                            //         fontWeight: FontWeight.w600,
                            //         fontSize: 26.sp),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (_isLoading)
                Center(
                  child: LoaderTransparent(color: Colors.white),
                ),
            ],
          );
  }
}
