import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jk_otm/Providers/auth_provider.dart';
import 'package:jk_otm/Reusable%20components/homepage_grid.dart';
import 'package:jk_otm/Reusable%20components/loading.dart';
import 'package:jk_otm/Reusable%20components/text_field.dart';
import 'package:jk_otm/main.dart';
import 'package:jk_otm/models/user_role_model.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool _isLoading = false;
  bool showDropdown = false;
  bool showProfileDropdown = false;
  UserRoleModel? selectedRole;

  @override
  void initState() {
    super.initState();
    _loadRoles();
  }

  Future<void> _loadRoles() async {
    setState(() {
      _isLoading = true;
    });

    await Provider.of<AuthProvider>(context, listen: false)
        .getRolesAndModules(context);

    if (!mounted) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final roles = authProvider.userRoleResponse?.data ?? [];
    if (roles.isNotEmpty) {
      selectedRole = roles.first;
    }

    setState(() {
      _isLoading = false;
    });
  }

  bool productsOpen = false;
  bool clothingOpen = false;
  bool homeOpen = false;
  bool servicesOpen = false;
  bool supportOpen = false;

  @override
  Widget build(BuildContext context) {
    final providerAuth = Provider.of<AuthProvider>(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                width: double.infinity,
                color: Color(0xffFFEB00),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                child: SafeArea(
                  bottom: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo
                      Image.asset("assets/jklogtrans.png", width: 300.w),

                      // Home Icon and User Dropdown
                      Row(
                        children: [
                          // Home Icon Button
                          InkWell(
                            onTap: () {
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
                            child: Container(
                              margin: EdgeInsets.only(bottom: 2.h),
                              child: SvgPicture.asset("assets/home.svg",
                                  height: 34.h, width: 30.w),
                            ),
                          ),

                          SizedBox(width: 25.w),

                          // User Dropdown Button
                          InkWell(
                            onTap: () {
                              setState(() {
                                showDropdown = !showDropdown;
                                showProfileDropdown = false;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 18.w),
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 26.r,
                                child: Text(
                                  (providerAuth.user.isNotEmpty
                                      ? providerAuth.user[0].toUpperCase()
                                      : ""),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 32.0.w, top: 20.h, bottom: 20.h),
                child: Text(
                  selectedRole?.description ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 34.sp,
                  ),
                ),
              ),

              // Scrollable GridView
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: GridView.count(
                    padding: EdgeInsets.zero,
                    crossAxisCount: 2,
                    mainAxisSpacing: 29.h,
                    crossAxisSpacing: 14.w,
                    childAspectRatio: 1,
                    children: [
                      ...((selectedRole?.modules) ?? [])
                          .map((e) => HomepageGrid(
                              icon: e.code,
                              description: e.description,
                              summary: e.summary))
                          .toList()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Transparent overlay to detect taps outside dropdown
        if (showDropdown)
          InkWell(
            onTap: () {
              setState(() {
                showDropdown = false;
                showProfileDropdown = false;
              });
            },
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

        // Dropdown menu positioned at top-right
        if (showDropdown)
          Positioned(
            top: 120.h,
            right: 16.w,
            child: InkWell(
              onTap: () {
                // Prevent closing when tapping inside dropdown
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Show Profile Dropdown if open
                    if (showProfileDropdown) ...[
                      // Back button header
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 16.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: Colors.grey[300]!, width: 1),
                          ),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  showProfileDropdown = false;
                                });
                              },
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black),
                            ),
                            SizedBox(width: 30.w),
                            Text(
                              "Select Role",
                              style: textFieldStyle(
                                color: Colors.black,
                                fontSize: 28.sp,
                              ),
                            ),
                          ],
                        ),
                      ),

                      ...(providerAuth.userRoleResponse?.data ?? [])
                          .map(
                            (e) => InkWell(
                              onTap: () async {
                                setState(() {
                                  selectedRole = e;
                                });

                                await Future.delayed(
                                    Duration(milliseconds: 150));
                                setState(() {
                                  showProfileDropdown = false;
                                  showDropdown = false;
                                });
                                bool? canVibrate =
                                    await Vibration.hasVibrator();

                                if (canVibrate == true) {
                                  Vibration.vibrate(
                                      duration: 50); // 👈 1 second
                                }
                              },
                              child: Container(
                                width: 450.w,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 60.w, vertical: 16.h),
                                child: Row(
                                  children: [
                                    Text(
                                      e.description,
                                      style: textFieldStyle(
                                          color: selectedRole?.description ==
                                                  e.description
                                              ? Colors.blue
                                              : Colors.black,
                                          fontSize: 28.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),

                      // Profile options
                    ] else ...[
                      // Main menu
                      InkWell(
                        onTap: () {
                          setState(() {
                            showProfileDropdown = true;
                          });
                        },
                        child: iconText(
                            Icons.person,
                            check: true,
                            selectedRole?.description ?? ""),
                      ),
                      Divider(height: 1),
                      iconText(Icons.lock, "Change Password"),
                      Divider(height: 1),
                      InkWell(
                        onTap: () async {
                          await providerAuth.logout(context);
                        },
                        child: iconText(Icons.logout, "Sign Out", color: false),
                      ),
                    ],
                  ],
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

Widget dropdownBox(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        const Icon(Icons.arrow_drop_down),
      ],
    ),
  );
}

Widget iconText(IconData icons, String text,
    {bool color = true, bool check = false}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 16.h),
    child: Row(
      children: [
        Icon(
          icons,
          color: color ? Colors.black : Colors.red,
        ),
        SizedBox(width: 40.w),
        Text(text,
            style: textFieldStyle(
                color: color ? Colors.black : Colors.red, fontSize: 28.sp)),
        SizedBox(width: 20.w),
        if (check)
          Icon(
            Icons.arrow_forward_outlined,
            size: 37.sp,
            color: Colors.black,
          ),
      ],
    ),
  );
}
