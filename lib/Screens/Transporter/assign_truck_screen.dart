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

class AssignTruckListScreen extends StatefulWidget {
  const AssignTruckListScreen({super.key});

  @override
  State<AssignTruckListScreen> createState() => _ShipmentListScreenState();
}

class _ShipmentListScreenState extends State<AssignTruckListScreen> {
  bool _isLoading = false;
  bool showDropdown = false;
  bool showProfileDropdown = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    Provider.of<TransporterProvider>(context, listen: false)
        .fetchApprovedDomesticIndents(context)
        .then((value) {
      Provider.of<TransporterProvider>(context, listen: false)
          .fetchMasterTrucks(context);
    }).then((value) {
      Provider.of<TransporterProvider>(context, listen: false)
          .fetchMasterDriverLicense(context);
    }).then((value) {
      setState(() {
        _isLoading = false;
      });
    });
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
                  "Assign Truck",
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
                    // SizedBox(width: 30.w),
                    InkWell(
                      onTap: providerTransporter.assignTruck
                              .any((indent) => indent.isSelected)
                          ? () {
                              final selectedIndents = providerTransporter
                                  .assignTruck
                                  .where((indent) => indent.isSelected)
                                  .toList();

                              _showMassUpdateDialog(selectedIndents);
                            }
                          : null,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 2.h),
                        child: SvgPicture.asset("assets/edit.svg",
                            color: providerTransporter.assignTruck
                                    .any((indent) => indent.isSelected)
                                ? Colors.black
                                : Colors.grey,
                            height: 36.h,
                            width: 30.w),
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Content Below
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: providerTransporter.assignTruck.length,
                  itemBuilder: (context, index) {
                    return shipmentCard(providerTransporter.assignTruck[index]);
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

  Future<void> _showMassUpdateDialog(
      List<TransporterIndent> selectedIndents) async {
    final providerTransporter =
        Provider.of<TransporterProvider>(context, listen: false);

    // Store the original context to use for showing the success dialog later
    final originalContext = context;

    VehicleNumberModel? selectedVehicle =
        VehicleNumberModel(truckNo: selectedIndents[0].turckNo);
    DriverMaster? selectedDriverLicense =
        DriverMaster(drivLicNo: selectedIndents[0].diverNo);

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              insetPadding:
                  EdgeInsets.symmetric(horizontal: 40.w, vertical: 60.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
              child: Container(
                width: 1100.w,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mass Update",
                          style: textFieldStyle(
                            fontSize: 32.sp,
                            weight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.of(dialogContext).pop(),
                          child: Icon(Icons.close, size: 30.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // IDs column
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "IDs",
                                style: textFieldStyle(
                                  fontSize: 26.sp,
                                  weight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  color: Colors.grey.shade100,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 12.h),
                                constraints: BoxConstraints(maxHeight: 260.h),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: selectedIndents
                                        .map(
                                          (e) => Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 6.h),
                                            child: Text(
                                              e.shipment,
                                              style: textFieldStyle(
                                                fontSize: 24.sp,
                                                weight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 40.w),
                        // Fields column
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Fields",
                                style: textFieldStyle(
                                  fontSize: 26.sp,
                                  weight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 24.h),
                              // Vehicle Number field
                              Text(
                                "Vehicle Number",
                                style: textFieldStyle(
                                  fontSize: 22.sp,
                                  weight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10.h),

                              SizedBox(
                                width: 600.w,
                                child: DropdownSearch<VehicleNumberModel>(
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      style: textFieldStyle(
                                        fontSize: 21.sp,
                                        weight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Search vehicle...",
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 18.w, vertical: 16.h),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                        ),
                                      ),
                                    ),
                                    menuProps: MenuProps(
                                      backgroundColor: Colors.white,
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    emptyBuilder: (context, searchEntry) {
                                      return Padding(
                                        padding: EdgeInsets.all(16.w),
                                        child: Text(
                                          "No vehicle found",
                                          style: textFieldStyle(
                                            fontSize: 21.sp,
                                            weight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  items: providerTransporter.trucks,
                                  itemAsString: (item) => item.truckNo,
                                  selectedItem: selectedVehicle,
                                  onChanged: (value) {
                                    setDialogState(() {
                                      selectedVehicle = value;
                                    });
                                  },
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 18.w, vertical: 16.h),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.arrow_drop_down,
                                              size: 28.sp),
                                          SizedBox(width: 8.w),
                                          Icon(Icons.search, size: 28.sp),
                                          SizedBox(width: 8.w),
                                          Icon(Icons.add, size: 28.sp),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 24.h),
                              // Driver License Number field
                              Text(
                                "Driver License Number",
                                style: textFieldStyle(
                                  fontSize: 22.sp,
                                  weight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10.h),

                              SizedBox(
                                width: 600.w,
                                child: DropdownSearch<DriverMaster>(
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      style: textFieldStyle(
                                        fontSize: 21.sp,
                                        weight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        hintText:
                                            "Search driver License Number...",
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 18.w, vertical: 16.h),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                        ),
                                      ),
                                    ),
                                    menuProps: MenuProps(
                                      backgroundColor: Colors.white,
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    emptyBuilder: (context, searchEntry) {
                                      return Padding(
                                        padding: EdgeInsets.all(16.w),
                                        child: Text(
                                          "No driver license found",
                                          style: textFieldStyle(
                                            fontSize: 21.sp,
                                            weight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  items: providerTransporter.driverLicenseList,
                                  itemAsString: (item) => item.drivLicNo,
                                  selectedItem: selectedDriverLicense,
                                  onChanged: (value) {
                                    setDialogState(() {
                                      selectedDriverLicense = value;
                                    });
                                  },
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 18.w, vertical: 16.h),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.arrow_drop_down,
                                              size: 28.sp),
                                          SizedBox(width: 8.w),
                                          Icon(Icons.search, size: 28.sp),
                                          SizedBox(width: 8.w),
                                          Icon(Icons.add, size: 28.sp),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32.w, vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                              side: BorderSide(color: Colors.red, width: 1),
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: textFieldStyle(
                              fontSize: 22.sp,
                              weight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF21412A),
                            padding: EdgeInsets.symmetric(
                                horizontal: 32.w, vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          onPressed: () async {
                            // Validate that vehicle and driver are selected
                            // if (selectedVehicle == null ||
                            //     selectedDriverLicense == null) {
                            //   return;
                            // }

                            // Build orderlist from selected indents
                            final orderlist = selectedIndents
                                .map((indent) => indent.shipment)
                                .where((shipment) => shipment.isNotEmpty)
                                .join(',');

                            // Close the current dialog first
                            Navigator.of(dialogContext).pop();
                            // Set loading to true before API call

                            setState(() {
                              _isLoading = true;
                            });

                            try {
                              // Call the API

                              final response = await providerTransporter
                                  .assignTruckDriverToIndents(
                                originalContext,
                                orderlist: orderlist,
                                truckNo: selectedVehicle?.truckNo ?? "",
                                driverNo:
                                    selectedDriverLicense?.drivLicNo ?? "",
                              );

                              log('$response checking if right');

                              if (response == true) {
                                log('innn checking if right');

                                // Refresh the list after successful assignment
                                await providerTransporter
                                    .fetchApprovedDomesticIndents(
                                        originalContext);

                                // Show success dialog - use originalContext to ensure it works after dialog is closed
                                if (originalContext.mounted) {
                                  showDialog(
                                    context: originalContext,
                                    builder: (context) {
                                      // Different variable name
                                      return AlertDialog(
                                        titlePadding: EdgeInsets.symmetric(
                                            horizontal: 16.w, vertical: 20.h),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16.w,
                                        ),
                                        actionsPadding: EdgeInsets.symmetric(
                                          horizontal: 16.w,
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Saving...',
                                              style: textFieldStyle(
                                                fontSize: 32.sp,
                                                weight: FontWeight.w600,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () =>
                                                  Navigator.of(context).pop(),
                                              child: Icon(Icons.close,
                                                  size: 30.sp),
                                            ),
                                          ],
                                        ),
                                        content: SizedBox(
                                          width: double.maxFinite,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Shipments:',
                                                  style: textFieldStyle(
                                                    fontSize: 30.sp,
                                                    weight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(height: 8.h),
                                                ...(providerTransporter
                                                    .assignTruckDriverResponse!
                                                    .data
                                                    .map((e) => Card(
                                                          elevation: 4,
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        19.h,
                                                                    horizontal:
                                                                        19.w),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      e.orderId,
                                                                      style:
                                                                          textFieldStyle(
                                                                        fontSize:
                                                                            28.sp,
                                                                        weight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            8.h),
                                                                    Text(
                                                                      e.postMsg,
                                                                      style:
                                                                          textFieldStyle(
                                                                        fontSize:
                                                                            22.sp,
                                                                        weight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Spacer(),
                                                                e.postStatus ==
                                                                        "1"
                                                                    ? SvgPicture
                                                                        .asset(
                                                                        "assets/greentick.svg",
                                                                        height:
                                                                            30.h,
                                                                        width:
                                                                            30.w,
                                                                        color: Colors
                                                                            .green,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      )
                                                                    : SvgPicture
                                                                        .asset(
                                                                        "assets/warning.svg",
                                                                        height:
                                                                            30.h,
                                                                        width:
                                                                            30.w,
                                                                        color: Colors
                                                                            .amber
                                                                            .shade700,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      )
                                                              ],
                                                            ),
                                                          ),
                                                        ))).toList()
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'OK',
                                              style: textFieldStyle(
                                                fontSize: 22.sp,
                                                weight: FontWeight.w600,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            } finally {
                              // Set loading to false after API call completes
                              if (mounted) {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            }
                          },
                          child: Text(
                            "Save",
                            style: textFieldStyle(
                              fontSize: 22.sp,
                              weight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
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
                  // Unselect all items first
                  final providerTransporter =
                      Provider.of<TransporterProvider>(context, listen: false);
                  for (var item in providerTransporter.assignTruck) {
                    item.isSelected = false;
                  }
                  // Then select the current item
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
                  shipment.shipment ?? "",
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
                  shipment.srcName ?? "",
                ),
                infoRow(
                  Icons.location_on_outlined,
                  "City",
                  shipment.city ?? "",
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
