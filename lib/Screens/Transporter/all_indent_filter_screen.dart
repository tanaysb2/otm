import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jk_otm/Providers/auth_provider.dart';
import 'package:jk_otm/Providers/transporter_provider.dart';
import 'package:jk_otm/Reusable%20components/loading.dart';
import 'package:jk_otm/Reusable%20components/text_field.dart';
import 'package:jk_otm/main.dart';
import 'package:jk_otm/models/driver_license_model.dart';
import 'package:jk_otm/models/transporter_indents_model.dart';
import 'package:jk_otm/models/vehicle_number_model.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';

class AllIndentFilterScreen extends StatefulWidget {
  const AllIndentFilterScreen({super.key});

  @override
  State<AllIndentFilterScreen> createState() => _ShipmentListScreenState();
}

class _ShipmentListScreenState extends State<AllIndentFilterScreen> {
  bool _isLoading = false;
  bool showDropdown = false;
  bool showProfileDropdown = false;

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   _isLoading = true;
    // });
    // Provider.of<TransporterProvider>(context, listen: false)
    //     .fetchApprovedDomesticIndents(context)
    //     .then((value) {
    //   Provider.of<TransporterProvider>(context, listen: false)
    //       .fetchMasterTrucks(context);
    // }).then((value) {
    //   Provider.of<TransporterProvider>(context, listen: false)
    //       .fetchMasterDriverLicense(context);
    // }).then((value) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final providerAuth = Provider.of<AuthProvider>(context);
    final providerTransporter = Provider.of<TransporterProvider>(context);

    // Reset dropdown when no items are selected

    return Stack(
      children: [
        Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Fixed Header Container 1 (Yellow Header)
              Container(
                width: double.infinity,
                color: Color(0xffFFEB00),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                child: SafeArea(
                  bottom: false,
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back, size: 40.sp)),
                      SizedBox(width: 8.w),
                      Image.asset(
                        "assets/jklogtrans.png",
                        width: 300.w,
                      ),
                      Spacer(),
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
                                fontSize: 30.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.only(left: 20.0.w),
                child: Text(
                  "All Indents Finder",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 34.sp,
                  ),
                ),
              ),
              // Fixed Container 2 (Action Dropdown)

              // Scrollable Content Below
              Expanded(
                child: providerTransporter.allIndentsSearchResults.isEmpty
                    ? Center(
                        child: Text(
                          "No records found",
                          style: textFieldStyle(
                            fontSize: 28.sp,
                            color: Colors.black,
                            weight: FontWeight.w500,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount:
                            providerTransporter.allIndentsSearchResults.length,
                        itemBuilder: (context, index) {
                          return shipmentCard(providerTransporter
                              .allIndentsSearchResults[index]);
                        },
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
                    if (showProfileDropdown) ...[
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
                    ] else ...[
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
          Positioned.fill(
            child: Center(
              child: LoaderTransparent(color: Colors.white),
            ),
          ),
      ],
    );
  }

  Widget shipmentCard(TransporterIndent shipment) {
    return Container(
      margin: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 20.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shipment.shipment,
                  style: textFieldStyle(
                    fontSize: 30.sp,
                    weight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                infoRow(
                  Icons.schedule,
                  "Pickup",
                  "${shipment.pickDate} ${shipment.pickTime}",
                ),
                infoRow(
                  Icons.factory_outlined,
                  "Source",
                  shipment.srcName,
                ),
                infoRow(
                  Icons.location_on_outlined,
                  "City",
                  shipment.city,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 32.sp,
            color: Colors.grey.shade900,
          ),
          const SizedBox(width: 8),
          Container(
            width: 120.w,
            child: Text(
              "$label:",
              style: textFieldStyle(
                fontSize: 25.sp,
                weight: FontWeight.w500,
                color: Colors.grey.shade900,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Container(
            width: 300.w,
            child: Text(
              value,
              style: textFieldStyle(
                  fontSize: 25.sp,
                  weight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget fieldText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 14),
          children: [
            TextSpan(
              text: "$title: ",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
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
 