import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jk_otm/Providers/auth_provider.dart';
import 'package:jk_otm/Providers/tertiary_provider.dart';
import 'package:jk_otm/Reusable%20components/loading.dart';
import 'package:jk_otm/Reusable%20components/text_field.dart';
import 'package:jk_otm/Screens/Tertiary/invoice_detail_screen.dart';
import 'package:jk_otm/Screens/landing_screen.dart';
import 'package:jk_otm/main.dart';
import 'package:jk_otm/models/dealers_detail_tertiary_model.dart';
import 'package:provider/provider.dart';

class InvoiceScreen extends StatefulWidget {
  final String tripId;
  final String dealerCode;

  InvoiceScreen({super.key, required this.tripId, required this.dealerCode});

  @override
  State<InvoiceScreen> createState() => _ShipmentListScreenState();
}

class _ShipmentListScreenState extends State<InvoiceScreen> {
  bool _isLoading = false;
  bool showDropdown = false;
  bool showProfileDropdown = false;

  String? selectedAction;

  int indexx = 0;
  bool errorShow = false;
  int tab = 1;

  @override
  void initState() {
    super.initState();

    setState(() {
      _isLoading = true;
    });
    log("tanay tripId: ${widget.tripId}");
    log("tanay dealerCode: ${widget.dealerCode}");

    Provider.of<TertiaryProvider>(context, listen: false)
        .fetchTertiaryServiceProviderTripDealer(context,
            tripId: widget.tripId, dealerCode: widget.dealerCode)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerAuth = Provider.of<AuthProvider>(context);
    final providerTransporter = Provider.of<TertiaryProvider>(context);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
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
                  "Dealer Details",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.sp,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Builder(
                builder: (context) {
                  final data = providerTransporter.invoiceDetailResponse?.data;
                  final kunnr = (data != null && data.isNotEmpty)
                      ? data.first.custName
                      : null;
                  if (kunnr == null || kunnr.isEmpty) {
                    return SizedBox.shrink();
                  }
                  return Padding(
                    padding: EdgeInsets.only(left: 20.0.w),
                    child: Text(
                      "Dealer Name : $kunnr",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.sp,
                      ),
                    ),
                  );
                },
              ),

              // Scrollable content; footer below stays pinned to screen bottom
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(bottom: 8.h),
                  children: [
                    ...(providerTransporter.invoiceDetailResponse?.data
                            .map((e) => customTile(e, context, () {}, "")) ??
                        []),
                  ],
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
          Center(
            child: LoaderTransparent(color: Colors.white),
          ),
      ],
    );
  }

  Widget customTile(
    DealersDetail document,
    BuildContext context,
    final Function callback,
    String type,
  ) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return InvoiceDetailScreen(trip: document);
            },
          ),
        );
      },
      child: Container(
        width: double.infinity,

        // padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 14.h),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.white),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0.0, 0.4), //(x,y)
              blurRadius: 0.6,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 15.w, top: 20.h),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Invoice No.",
                            style: textFieldStyle(
                              color: Colors.grey.shade800,
                              fontSize: 26.sp,
                              weight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          SizedBox(
                            width: 600.w,
                            child: Text(
                              document.invNo,
                              maxLines: 2,
                              style: textFieldStyle(
                                color: Color.fromARGB(255, 1, 77, 138),
                                fontSize: 28.sp,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                      // SizedBox(width: 40.w),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Invoice Date",
                            style: textFieldStyle(
                              color: Colors.grey.shade800,
                              fontSize: 26.sp,
                              weight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          SizedBox(
                            width: 600.w,
                            child: Text(
                              document.invDt,
                              maxLines: 2,
                              style: textFieldStyle(
                                color: Color.fromARGB(255, 1, 77, 138),
                                fontSize: 28.sp,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),

                      // Row(
                      //   children: [
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           "Delear Code",
                      //           style: textFieldStyle(
                      //             color: Colors.grey.shade800,
                      //             fontSize: 26.sp,
                      //             weight: FontWeight.w500,
                      //           ),
                      //         ),
                      //         SizedBox(height: 3.h),
                      //         SizedBox(
                      //           width: 200.w,
                      //           child: Text(
                      //             document.kunnr,
                      //             maxLines: 2,
                      //             style: textFieldStyle(
                      //               color: Color.fromARGB(255, 1, 77, 138),
                      //               fontSize: 28.sp,
                      //               weight: FontWeight.w700,
                      //             ),
                      //           ),
                      //         ),
                      //         SizedBox(height: 10.h),
                      //       ],
                      //     ),
                      //     SizedBox(width: 40.w),
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           "Customer Name",
                      //           style: textFieldStyle(
                      //             color: Colors.grey.shade800,
                      //             fontSize: 26.sp,
                      //             weight: FontWeight.w500,
                      //           ),
                      //         ),
                      //         SizedBox(height: 3.h),
                      //         Text(
                      //           document.custName,
                      //           style: textFieldStyle(
                      //             color: Color.fromARGB(255, 1, 77, 138),
                      //             fontSize: 28.sp,
                      //             weight: FontWeight.w700,
                      //           ),
                      //         ),
                      //         SizedBox(height: 10.h),
                      //       ],
                      //     ),
                      //   ],
                      // ),

                      // SizedBox(height: 3.h),

                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Bill Qty.",
                                style: textFieldStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 26.sp,
                                  weight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              SizedBox(
                                width: 200.w,
                                child: Text(
                                  document.billQty,
                                  maxLines: 2,
                                  style: textFieldStyle(
                                    color: Color.fromARGB(255, 1, 77, 138),
                                    fontSize: 28.sp,
                                    weight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                          SizedBox(width: 40.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Bill Tte.",
                                style: textFieldStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 26.sp,
                                  weight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                document.billTte,
                                style: textFieldStyle(
                                  color: Color.fromARGB(255, 1, 77, 138),
                                  fontSize: 28.sp,
                                  weight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ],
                      ),

                      // SizedBox(height: 3.h),

                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Invoice Qty.",
                                style: textFieldStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 26.sp,
                                  weight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              SizedBox(
                                width: 200.w,
                                child: Text(
                                  document.invCnt,
                                  maxLines: 2,
                                  style: textFieldStyle(
                                    color: Color.fromARGB(255, 1, 77, 138),
                                    fontSize: 28.sp,
                                    weight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                          SizedBox(width: 40.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dealer Cnt.",
                                style: textFieldStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 26.sp,
                                  weight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                document.dlrCnt,
                                style: textFieldStyle(
                                  color: Color.fromARGB(255, 1, 77, 138),
                                  fontSize: 28.sp,
                                  weight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
