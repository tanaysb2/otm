import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jk_otm/Providers/auth_provider.dart';
import 'package:jk_otm/Providers/tertiary_provider.dart';
import 'package:jk_otm/Reusable%20components/loading.dart';
import 'package:jk_otm/Reusable%20components/text_field.dart';
import 'package:jk_otm/Screens/Tertiary/invoice_screen.dart';
import 'package:jk_otm/Screens/landing_screen.dart';
import 'package:jk_otm/main.dart';
import 'package:jk_otm/models/dealers_detail_tertiary_model.dart';
import 'package:jk_otm/models/invoice_detail_model.dart';
import 'package:provider/provider.dart';

class InvoiceDetailScreen extends StatefulWidget {
  final DealersDetail trip;

  InvoiceDetailScreen({super.key, required this.trip});

  @override
  State<InvoiceDetailScreen> createState() => _ShipmentListScreenState();
}

class _ShipmentListScreenState extends State<InvoiceDetailScreen> {
  bool _isLoading = false;
  bool showDropdown = false;
  bool showProfileDropdown = false;
  double? currentLatitude;
  double? currentLongitude;
  String? selectedAction;
  final ImagePicker _imagePicker = ImagePicker();

  /// Up to three attachment images, one per slot below the picker UI.
  final List<XFile?> _imageSlots = <XFile?>[null, null, null];

  int indexx = 0;
  bool errorShow = false;
  int tab = 1;

  @override
  void initState() {
    super.initState();

    setState(() {
      _isLoading = true;
    });
    Provider.of<TertiaryProvider>(context, listen: false)
        .clearDocumentNamesByDocumentId();
    Provider.of<TertiaryProvider>(context, listen: false)
        .fetchTertiaryServiceProviderTripDealerInvoice(context,
            tripId: widget.trip.tripId,
            dealerCode: widget.trip.kunnr,
            invoiceNo: widget.trip.invNo)
        .then((_) {
      _resolveCurrentLocation();
      setState(() {
        _isLoading = false;
      });
    });
  }

  /// Current device coordinates when permission and services allow (e.g. for APIs).

  Future<void> _resolveCurrentLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        log('invoice_screen: location services disabled');
        return;
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        log('invoice_screen: location permission denied');
        return;
      }
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      if (!mounted) return;
      setState(() {
        currentLatitude = pos.latitude;
        currentLongitude = pos.longitude;
      });
      log(
        'invoice_screen: lat=${pos.latitude}, lng=${pos.longitude}',
      );
    } catch (e, st) {
      log('invoice_screen: location error: $e', stackTrace: st);
    }
  }

  void _showImageSourceBottomSheet(int slotIndex) {
    if (slotIndex < 0 || slotIndex >= _imageSlots.length) return;
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt, size: 28.sp),
                  title: Text(
                    'Take photo',
                    style: textFieldStyle(
                      color: Colors.black,
                      fontSize: 26.sp,
                      weight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    _capturePhotoFromCamera(slotIndex);
                  },
                ),
                Divider(height: 1.h),
                ListTile(
                  leading: Icon(Icons.photo_library, size: 28.sp),
                  title: Text(
                    'Gallery',
                    style: textFieldStyle(
                      color: Colors.black,
                      fontSize: 26.sp,
                      weight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    _pickPhotoFromGallery(slotIndex);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Opens the device camera for [slotIndex] (0..2).
  Future<void> _capturePhotoFromCamera(int slotIndex) async {
    try {
      final picked = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );
      if (!mounted || picked == null) return;

      final tertiaryProvider =
          Provider.of<TertiaryProvider>(context, listen: false);
      final bytes = await picked.readAsBytes();

      final documentId = '${slotIndex + 1}';
      final urlOk = await tertiaryProvider
          .fetchTertiaryServiceProviderTripDealerDocumentUploadUrl(
        context,
        tripId: widget.trip.tripId,
        bytes: bytes,
        dealerCode: widget.trip.kunnr,
        documentId: documentId,
        latitude: (currentLatitude ?? 0).toString(),
        longitude: (currentLongitude ?? 0).toString(),
      );
      if (!mounted || !urlOk) return;

      setState(() {
        _imageSlots[slotIndex] = picked;
      });
    } catch (e, st) {
      log('invoice_detail_screen: camera error: $e', stackTrace: st);
    }
  }

  /// Opens gallery for [slotIndex] (0..2).
  Future<void> _pickPhotoFromGallery(int slotIndex) async {
    try {
      final picked = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (!mounted || picked == null) return;

      final tertiaryProvider =
          Provider.of<TertiaryProvider>(context, listen: false);
      final bytes = await picked.readAsBytes();
      final documentId = '${slotIndex + 1}';
      final urlOk = await tertiaryProvider
          .fetchTertiaryServiceProviderTripDealerDocumentUploadUrl(
        context,
        tripId: widget.trip.tripId,
        bytes: bytes,
        dealerCode: widget.trip.kunnr,
        documentId: documentId,
        latitude: (currentLatitude ?? 0).toString(),
        longitude: (currentLongitude ?? 0).toString(),
      );
      if (!mounted || !urlOk) return;

      setState(() {
        _imageSlots[slotIndex] = picked;
      });
    } catch (e, st) {
      log('invoice_detail_screen: gallery error: $e', stackTrace: st);
    }
  }

  void _openImageFullScreen(String imagePath) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (ctx) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: SafeArea(
            child: Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4,
                child: Image.file(
                  File(imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
                  "Invoice Details",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.sp,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.only(left: 20.0.w),
                child: Text(
                  "Invoice No : ${widget.trip.invNo}",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.sp,
                  ),
                ),
              ),

              // Scrollable Content Below
              Expanded(
                child: providerTransporter.tripDetailDealersResponse == null
                    ? SizedBox.shrink()
                    : ListView.builder(
                        padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                        itemCount: providerTransporter.invoiceDetail.length,
                        itemBuilder: (context, index) {
                          final dealer =
                              providerTransporter.invoiceDetail[index];
                          return customTile(dealer, context, () {}, "");
                        },
                      ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(3, (index) {
                        final image = _imageSlots[index];
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: index < 2 ? 10.w : 0,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => _showImageSourceBottomSheet(index),
                                borderRadius: BorderRadius.circular(8.r),
                                child: Container(
                                  height: 110.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffFFEB00)
                                        .withOpacity(0.35),
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: Colors.grey.shade500,
                                      width: 1,
                                    ),
                                  ),
                                  child: image == null
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons
                                                  .add_photo_alternate_outlined,
                                              size: 36.sp,
                                              color: Colors.black87,
                                            ),
                                            SizedBox(height: 6.h),
                                            Text(
                                              'Photo ${index + 1}',
                                              textAlign: TextAlign.center,
                                              style: textFieldStyle(
                                                color: Colors.black87,
                                                fontSize: 20.sp,
                                                weight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Stack(
                                          clipBehavior: Clip.none,
                                          fit: StackFit.expand,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              child: GestureDetector(
                                                onTap: () =>
                                                    _openImageFullScreen(
                                                        image.path),
                                                child: Image.file(
                                                  File(image.path),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              right: 0,
                                              bottom: 0,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  bottom: Radius.circular(8.r),
                                                ),
                                                child: Material(
                                                  color: Colors.black
                                                      .withOpacity(0.55),
                                                  child: InkWell(
                                                    onTap: () =>
                                                        _showImageSourceBottomSheet(
                                                            index),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 8.h,
                                                        horizontal: 4.w,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .photo_camera_back_outlined,
                                                            color: Colors.white,
                                                            size: 18.sp,
                                                          ),
                                                          SizedBox(width: 6.w),
                                                          Text(
                                                            'Select again',
                                                            style:
                                                                textFieldStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18.sp,
                                                              weight: FontWeight
                                                                  .w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              Container(
                height: 100.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0.0, 0.4), //(x,y)
                        blurRadius: 0.6,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      final ok = await providerTransporter
                          .fetchTertiaryServiceProviderTripDealerDeliveriesComplete(
                        context,
                        tripId: widget.trip.tripId,
                        dealerCode: widget.trip.kunnr,
                        documents: providerTransporter
                            .documentNamesOrderedByDocumentId(),
                      );
                      if (!mounted) return;
                      if (ok) {
                        Navigator.of(context).pop();
                      }
                    } finally {
                      if (mounted) {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Mark as Completed",
                          style: textFieldStyle(
                              color: Color.fromARGB(255, 1, 77, 138),
                              fontSize: 28.sp,
                              weight: FontWeight.w700)),
                      SizedBox(width: 10.w),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 30.sp,
                        color: Color.fromARGB(255, 1, 77, 138),
                      )
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
    InvoiceDetailModel document,
    BuildContext context,
    final Function callback,
    String type,
  ) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return InvoiceScreen(
                  tripId: document.tripId, dealerCode: document.kunnr);
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
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       "Trip ID",
                      //       style: textFieldStyle(
                      //         color: Colors.grey.shade800,
                      //         fontSize: 26.sp,
                      //         weight: FontWeight.w500,
                      //       ),
                      //     ),
                      //     SizedBox(height: 3.h),
                      //     SizedBox(
                      //       width: 600.w,
                      //       child: Text(
                      //         document.tripId,
                      //         maxLines: 2,
                      //         style: textFieldStyle(
                      //           color: Color.fromARGB(255, 1, 77, 138),
                      //           fontSize: 28.sp,
                      //           weight: FontWeight.w700,
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(height: 10.h),
                      //   ],
                      // ),
                      // // SizedBox(width: 40.w),

                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Material Name",
                                style: textFieldStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 26.sp,
                                  weight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              SizedBox(
                                width: 250.w,
                                child: Text(
                                  document.maktx,
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
                                "Material Code",
                                style: textFieldStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 26.sp,
                                  weight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              SizedBox(
                                width: 330.w,
                                child: Text(
                                  document.matnr,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
                                width: 250.w,
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
                                width: 250.w,
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
