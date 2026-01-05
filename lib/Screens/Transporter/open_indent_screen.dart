import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jk_otm/Providers/auth_provider.dart';
import 'package:jk_otm/Providers/transporter_provider.dart';
import 'package:jk_otm/Reusable%20components/loading.dart';
import 'package:jk_otm/Reusable%20components/text_field.dart';
import 'package:jk_otm/main.dart';
import 'package:jk_otm/models/transporter_indents_model.dart';
import 'package:provider/provider.dart';

class ShipmentListScreen extends StatefulWidget {
  const ShipmentListScreen({super.key});

  @override
  State<ShipmentListScreen> createState() => _ShipmentListScreenState();
}

class _ShipmentListScreenState extends State<ShipmentListScreen> {
  bool _isLoading = false;
  bool showDropdown = false;
  bool showProfileDropdown = false;

  String? selectedAction;

  final List<String> actions = [
    'Accept Tender',
    'Reject Tender',
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    Provider.of<TransporterProvider>(context, listen: false)
        .fetchOpenDomesticIndents(context)
        .then((value) {
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
    if (!providerTransporter.openIndents.any((indent) => indent.isSelected)) {
      selectedAction = null;
    }

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
                  "Open Indents",
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: providerTransporter.openIndents
                                    .any((indent) => indent.isSelected)
                                ? Colors.black54
                                : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(6),
                          color: providerTransporter.openIndents
                                  .any((indent) => indent.isSelected)
                              ? Colors.white
                              : Colors.grey.shade300,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedAction,
                            isExpanded: true,
                            isDense: true,
                            hint: Text(
                              'Actions',
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
                              return actions.map((String action) {
                                return Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    action,
                                    style: textFieldStyle(
                                      fontSize: 22.sp,
                                      weight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                            items: actions.map((action) {
                              return DropdownMenuItem<String>(
                                value: action,
                                child: Text(
                                  action,
                                  style: textFieldStyle(
                                    fontSize: 22.sp,
                                    weight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: providerTransporter.openIndents
                                    .any((indent) => indent.isSelected)
                                ? (value) async {
                                    selectedAction = value;

                                    // Get selected indents
                                    final selectedIndents = providerTransporter
                                        .openIndents
                                        .where((indent) => indent.isSelected)
                                        .toList();

                                    // Determine approveOrReject value based on action
                                    final approveOrReject =
                                        selectedAction == "Accept Tender"
                                            ? "A"
                                            : "R";

                                    // Build order list for API from selected shipments
                                    final shipmentIds = selectedIndents
                                        .map((indent) => indent.shipment)
                                        .toList();

                                    setState(() {
                                      _isLoading = true;
                                    });

                                    try {
                                      final response = await providerTransporter
                                          .approveRejectDomesticIndents(
                                        context,
                                        shipmentIds: shipmentIds,
                                        actionType: approveOrReject,
                                      );

                                      if (response == true) {
                                        // Refresh the list after successful approval/rejection
                                        await providerTransporter
                                            .fetchOpenDomesticIndents(context);

                                        // Show dialog with all selected shipments
                                        showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return AlertDialog(
                                              titlePadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 16.w,
                                                      vertical: 20.h),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                              ),
                                              actionsPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                              ),
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Tender updated successfully',
                                                    style: textFieldStyle(
                                                      fontSize: 32.sp,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () => Navigator.of(
                                                            dialogContext)
                                                        .pop(),
                                                    child: Icon(Icons.close,
                                                        size: 30.sp),
                                                  ),
                                                ],
                                              ),
                                              content: SizedBox(
                                                width: double.maxFinite,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Shipments:',
                                                        style: textFieldStyle(
                                                          fontSize: 30.sp,
                                                          weight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(height: 8.h),
                                                      ...(providerTransporter
                                                          .openIndentsResponse!
                                                          .data
                                                          .map((e) => Card(
                                                                elevation: 4,
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets.symmetric(
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
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            e.orderId,
                                                                            style:
                                                                                textFieldStyle(
                                                                              fontSize: 28.sp,
                                                                              weight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 8.h),
                                                                          Text(
                                                                            e.postMsg,
                                                                            style:
                                                                                textFieldStyle(
                                                                              fontSize: 22.sp,
                                                                              weight: FontWeight.w500,
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
                                                                              height: 30.h,
                                                                              width: 30.w,
                                                                              color: Colors.green,
                                                                              fit: BoxFit.fill,
                                                                            )
                                                                          : SvgPicture
                                                                              .asset(
                                                                              "assets/warning.svg",
                                                                              height: 30.h,
                                                                              width: 30.w,
                                                                              color: Colors.amber.shade700,
                                                                              fit: BoxFit.fill,
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
                                                    Navigator.of(dialogContext)
                                                        .pop();
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

                                      log('$selectedAction');
                                    } finally {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }

                                    setState(() {});
                                  }
                                : null,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30.w),
                    InkWell(
                      onTap: providerTransporter.openIndents
                              .any((indent) => indent.isSelected)
                          ? () {
                              final selectedIndents = providerTransporter
                                  .openIndents
                                  .where((indent) => indent.isSelected)
                                  .toList();

                              _showMassUpdateDialog(selectedIndents);
                            }
                          : null,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 2.h),
                        child: SvgPicture.asset("assets/edit.svg",
                            color: providerTransporter.openIndents
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
                  itemCount: providerTransporter.openIndents.length,
                  itemBuilder: (context, index) {
                    return shipmentCard(providerTransporter.openIndents[index]);
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
          Center(
            child: LoaderTransparent(color: Colors.white),
          ),
      ],
    );
  }

  Future<void> _showMassUpdateDialog(
      List<TransporterIndent> selectedIndents) async {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final TextEditingController dateTimeController =
        TextEditingController(text: _formatDateTime(now));

    Future<void> pickDateTime() async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: today,
        firstDate: today,
        lastDate: DateTime(2100),
      );

      if (pickedDate == null) return;

      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(now),
      );

      if (pickedTime == null) return;

      final DateTime combined = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      dateTimeController.text = _formatDateTime(combined);
    }

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 60.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: selectedIndents
                                    .map(
                                      (e) => Padding(
                                        padding: EdgeInsets.only(bottom: 6.h),
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
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "* ",
                                  style: textFieldStyle(
                                    fontSize: 22.sp,
                                    weight: FontWeight.w600,
                                    color: Colors.red,
                                  ),
                                ),
                                TextSpan(
                                  text: "Tentative Pickup Time",
                                  style: textFieldStyle(
                                    fontSize: 22.sp,
                                    weight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: 600.w,
                            child: TextField(
                              controller: dateTimeController,
                              readOnly: true,
                              onTap: pickDateTime,
                              style: textFieldStyle(
                                fontSize: 21.sp,
                                weight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 18.w, vertical: 16.h),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.calendar_today_outlined,
                                      size: 28.sp),
                                  onPressed: pickDateTime,
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
                        final providerTransporter =
                            Provider.of<TransporterProvider>(context,
                                listen: false);

                        // Parse the date time string
                        final dateTime =
                            _parseDateTime(dateTimeController.text);
                        if (dateTime == null) {
                          Navigator.of(dialogContext).pop();
                          return;
                        }

                        // Format pickDate as "yyyy-MM-dd" using intl
                        final String pickDate =
                            DateFormat('yyyy-MM-dd').format(dateTime);

                        // Format pickTime as "HH:mm:ss" using intl
                        final String pickTime =
                            DateFormat('HH:mm:ss').format(dateTime);

                        // Build the body array
                        final List<Map<String, String>> updates =
                            selectedIndents.map((indent) {
                          return {
                            "shipment": indent.shipment,
                            "pickDate": pickDate,
                            "pickTime": pickTime,
                          };
                        }).toList();
                        // Close the current dialog
                        Navigator.of(dialogContext).pop();

                        // Set loading to true before API call
                        setState(() {
                          _isLoading = true;
                        });

                        try {
                          // Call the API
                          final response = await providerTransporter
                              .massUpdateOpenDomesticIndents(
                            context,
                            updates: updates,
                          );
                          if (response == true) {
                            // Refresh the list after successful update
                            // Show dialog with all selected shipments
                            showDialog(
                              context: context,
                              builder: (dialogContext) {
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
                                        'Tender updated successfully',
                                        style: textFieldStyle(
                                          fontSize: 32.sp,
                                          weight: FontWeight.w600,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () =>
                                            Navigator.of(dialogContext).pop(),
                                        child: Icon(Icons.close, size: 30.sp),
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
                                              .openIndentsResponseForMassUpdate!
                                              .data
                                              .map((e) => Card(
                                                    elevation: 4,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 19.h,
                                                              horizontal: 19.w),
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
                                                                e.shipment,
                                                                style:
                                                                    textFieldStyle(
                                                                  fontSize:
                                                                      28.sp,
                                                                  weight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 8.h),
                                                              Text(
                                                                e.postMsg,
                                                                style:
                                                                    textFieldStyle(
                                                                  fontSize:
                                                                      22.sp,
                                                                  weight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          e.postStatus == "1"
                                                              ? SvgPicture
                                                                  .asset(
                                                                  "assets/greentick.svg",
                                                                  height: 30.h,
                                                                  width: 30.w,
                                                                  color: Colors
                                                                      .green,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                )
                                                              : SvgPicture
                                                                  .asset(
                                                                  "assets/warning.svg",
                                                                  height: 30.h,
                                                                  width: 30.w,
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
                                        Navigator.of(dialogContext).pop();
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
                        } finally {
                          // Set loading to false after API call completes
                          setState(() {
                            _isLoading = false;
                          });
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
  }

  String _formatDateTime(DateTime dateTime) {
    const List<String> monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final String day = twoDigits(dateTime.day);
    final String month = monthNames[dateTime.month - 1];
    final String year = dateTime.year.toString();
    final String hour = twoDigits(dateTime.hour);
    final String minute = twoDigits(dateTime.minute);
    final String second = twoDigits(dateTime.second);

    return "$day-$month-$year $hour:$minute:$second";
  }

  DateTime? _parseDateTime(String dateTimeString) {
    const List<String> monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    try {
      // Format: "DD-MMM-YYYY HH:mm:ss"
      final parts = dateTimeString.split(' ');
      if (parts.length != 2) return null;

      final datePart = parts[0].split('-');
      if (datePart.length != 3) return null;

      final timePart = parts[1].split(':');
      if (timePart.length != 3) return null;

      final day = int.parse(datePart[0]);
      final month = monthNames.indexOf(datePart[1]) + 1;
      final year = int.parse(datePart[2]);
      final hour = int.parse(timePart[0]);
      final minute = int.parse(timePart[1]);
      final second = int.parse(timePart[2]);

      return DateTime(year, month, day, hour, minute, second);
    } catch (e) {
      return null;
    }
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
