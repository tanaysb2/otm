import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jk_otm/Providers/auth_provider.dart';
import 'package:jk_otm/Providers/tertiary_provider.dart';
import 'package:jk_otm/Reusable%20components/loading.dart';
import 'package:jk_otm/Reusable%20components/text_field.dart';
import 'package:jk_otm/Screens/Tertiary/dealers_detail_screen.dart';
import 'package:jk_otm/main.dart';
import 'package:jk_otm/models/active_trips_model.dart';
import 'package:jk_otm/models/tertiary_route_model.dart';
import 'package:jk_otm/models/transporter_indents_model.dart';
import 'package:provider/provider.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({super.key});

  @override
  State<RouteScreen> createState() => _ShipmentListScreenState();
}

class _ShipmentListScreenState extends State<RouteScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  late ScrollController _controller;
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
    _tabController = TabController(length: 2, vsync: this);
    _controller = ScrollController();
    setState(() {
      _isLoading = true;
    });
    Provider.of<TertiaryProvider>(context, listen: false)
        .fetchTertiaryServiceProviderDepots(context)
        .then((_) {
      final tp = Provider.of<TertiaryProvider>(context, listen: false);
      String? firstLocCd;
      for (final RouteTertiaryModel d in tp.depots) {
        final c = d.locCd;
        if (c != null && c.isNotEmpty) {
          firstLocCd = c;
          break;
        }
      }
      if (mounted) {
        setState(() {
          selectedAction = firstLocCd;
        });
      }
      final loc = selectedAction ?? '';
      tp
          .fetchTertiaryServiceProviderActiveTrips(context, location: loc)
          .then((value) {
        tp
            .fetchTertiaryServiceProviderAllTrips(context, location: loc)
            .then((value) {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        });
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
                  "Trip Details",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 34.sp,
                  ),
                ),
              ),
              // Fixed Container 2 (Action Dropdown)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IntrinsicWidth(
                      child: Container(
                        height: 60.h,
                        width: 200.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedAction,
                            isExpanded: true,
                            isDense: true,
                            hint: Text(
                              'Location',
                              style: textFieldStyle(
                                fontSize: 22.sp,
                                weight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            icon: Icon(Icons.arrow_drop_down, size: 20.sp),
                            style: textFieldStyle(
                              fontSize: 22.sp,
                              weight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            selectedItemBuilder: (BuildContext context) {
                              final depots = providerTransporter.depots
                                  .where((d) =>
                                      d.locCd != null && d.locCd!.isNotEmpty)
                                  .toList();
                              return depots.map<Widget>((RouteTertiaryModel d) {
                                final label =
                                    (d.locName != null && d.locName!.isNotEmpty)
                                        ? d.locName!
                                        : d.locCd!;
                                return Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    label,
                                    style: textFieldStyle(
                                      fontSize: 22.sp,
                                      weight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                            items: providerTransporter.depots
                                .where((d) =>
                                    d.locCd != null && d.locCd!.isNotEmpty)
                                .map<DropdownMenuItem<String>>(
                                    (RouteTertiaryModel d) {
                              final label =
                                  (d.locName != null && d.locName!.isNotEmpty)
                                      ? d.locName!
                                      : d.locCd!;
                              return DropdownMenuItem<String>(
                                value: d.locCd,
                                child: Text(
                                  label,
                                  style: textFieldStyle(
                                    fontSize: 22.sp,
                                    weight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) async {
                              log('Selected Location (LocCd): $value');
                              setState(() {
                                selectedAction = value;
                              });
                              if (value != null) {
                                await Provider.of<TertiaryProvider>(context,
                                        listen: false)
                                    .fetchTertiaryServiceProviderActiveTrips(
                                        context,
                                        location: value);
                                await Provider.of<TertiaryProvider>(context,
                                        listen: false)
                                    .fetchTertiaryServiceProviderAllTrips(
                                        context,
                                        location: value);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30.w),
                  ],
                ),
              ),

              // Scrollable Content Below
              Expanded(
                child: Column(
                  children: [
                    // SizedBox(height: 10.h),
                    SizedBox(
                      child: Container(
                        width: double.infinity,
                        child: TabBar(
                          unselectedLabelColor: Colors.black87,
                          isScrollable: false,
                          onTap: (value) {
                            indexx = value;
                            setState(() {});
                            print("$value valueeee");
                          },
                          controller: _tabController,
                          labelColor: Color.fromARGB(255, 1, 77, 138),
                          indicatorColor: Color.fromARGB(255, 1, 77, 138),
                          labelStyle: TextStyle(
                              color: Colors.black87,
                              fontFamily: "NotoSans",
                              fontWeight: FontWeight.bold,
                              fontSize: 32.sp),
                          unselectedLabelStyle: TextStyle(
                              color: Colors.black87,
                              fontFamily: "NotoSans",
                              fontWeight: FontWeight.w400,
                              fontSize: 32.sp),
                          tabs: ([
                            "Active Trips (${providerTransporter.activeTrips.length})",
                            "All Trips (${providerTransporter.allTrips.length})"
                          ]).map((e) {
                            return Container(
                              child: Tab(text: e),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: indexx == 0
                            ? providerTransporter.activeTrips.length
                            : providerTransporter.allTrips.length,
                        itemBuilder: (context, index) {
                          return indexx == 0
                              ? providerTransporter.activeTrips.isEmpty
                                  ? SizedBox()
                                  : customTile(
                                      providerTransporter.activeTrips[index],
                                      context,
                                      () {},
                                      "ACTIVE TRIPS LIST",
                                    )
                              : providerTransporter.allTrips.isEmpty
                                  ? SizedBox()
                                  : customTile(
                                      providerTransporter.allTrips[index],
                                      context,
                                      () {},
                                      "ALL TRIPS LIST",
                                    );
                        },
                      ),
                    ),
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
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              value: shipment.isSelected,
              activeColor: Colors.amber.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              onChanged: (value) {
                setState(() {
                  shipment.isSelected = value ?? false;
                });
              },
            ),
          ),
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

Widget customTile(
  ActiveTripModel document,
  BuildContext context,
  final Function callback,
  String type,
) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return DealersDetailScreen(trip: document);
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
                          "Trip ID",
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
                            document.tripId,
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
                          "Route Name",
                          style: textFieldStyle(
                            color: Colors.grey.shade800,
                            fontSize: 26.sp,
                            weight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          document.routeName,
                          style: textFieldStyle(
                            color: Color.fromARGB(255, 1, 77, 138),
                            fontSize: 28.sp,
                            weight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
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
                              width: 320.w,
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
                              width: 320.w,
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
