import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jk_otm/Providers/auth_provider.dart';
import 'package:jk_otm/Providers/transporter_provider.dart';
import 'package:jk_otm/Reusable%20components/loading.dart';
import 'package:jk_otm/Reusable%20components/text_field.dart';
import 'package:jk_otm/Screens/Transporter/all_indent_filter_screen.dart';
import 'package:jk_otm/main.dart';
import 'package:jk_otm/models/source_loc_model.dart';
import 'package:jk_otm/models/transporter_model.dart';
import 'package:jk_otm/utils/api_interface.dart';
import 'package:provider/provider.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class AllIndentListScreen extends StatefulWidget {
  const AllIndentListScreen({super.key});

  @override
  State<AllIndentListScreen> createState() => _ShipmentListScreenState();
}

class _ShipmentListScreenState extends State<AllIndentListScreen> {
  bool _isLoading = false;
  bool showDropdown = false;
  bool showProfileDropdown = false;

  // Form controllers
  final TextEditingController _insertDateController = TextEditingController();
  final TextEditingController _shipmentIdController = TextEditingController();
  final TextEditingController _orderReleaseIdController =
      TextEditingController();
  final TextEditingController _lrNumberController = TextEditingController();
  final TextEditingController _transporterController = TextEditingController();
  final TextEditingController _destinationLocIdController =
      TextEditingController();
  final TextEditingController _truckNumberController = TextEditingController();

  // Multi-select controllers
  final MultiSelectController<LocationSourceData> _sourceLocController =
      MultiSelectController<LocationSourceData>();
  final MultiSelectController<LocationSourceData> _destinationLocController =
      MultiSelectController<LocationSourceData>();

  TransporterMaster? selectedTransport;

  String? _selectedDateComparison;
  String? _selectedCategory;

  final List<String> _dateComparisonOptions = [
    'None',
    'Same As',
    'After',
    'Before'
  ];
  final List<String> _categoryOptions = ['None', 'PCR', 'TBR'];

  @override
  void initState() {
    super.initState();
    _insertDateController.text =
        "${DateFormat('dd-MMM-yyyy').format(DateTime.now())}";
    _selectedDateComparison = 'After';
    start();
  }

  Future start() async {
    setState(() {
      _isLoading = true;
    });

    final provider = Provider.of<TransporterProvider>(context, listen: false);

    // Fetch all required data in parallel
    await Future.wait([
      provider.fetchMasterTransporters(context),
      provider.fetchSourceLocations(context),
      provider.fetchDestinationLoc(context),
    ]);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _insertDateController.dispose();
    _shipmentIdController.dispose();
    _orderReleaseIdController.dispose();
    _lrNumberController.dispose();
    _transporterController.dispose();
    _destinationLocIdController.dispose();
    _truckNumberController.dispose();
    _sourceLocController.dispose();
    _destinationLocController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerAuth = Provider.of<AuthProvider>(context);

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
              SizedBox(height: 36.h),

              // Scrollable Form Container
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width - 40.w,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row 1: Insert Date, Date Comparison
                          _buildFormRow([
                            _buildDateField(),
                            _buildDateComparisonField(),
                          ]),
                          SizedBox(height: 24.h),
                          // Row 2: Shipment ID, Order Release ID
                          _buildFormRow([
                            _buildTextField(
                                "Shipment ID", _shipmentIdController,
                                isRequired: false),
                            _buildTextField(
                                "Order Release ID", _orderReleaseIdController,
                                isRequired: false),
                          ]),
                          SizedBox(height: 24.h),
                          // Row 3: LR Number, Transporter
                          _buildFormRow([
                            _buildTextField("LR Number", _lrNumberController,
                                isRequired: false),
                            _buildTransporterField(),
                          ]),
                          SizedBox(height: 24.h),
                          // Row 4: Source Loc. ID (Multi-select), Destination Loc. ID
                          // _buildFormRow([
                          //   _buildSourceLocMultiSelectField(),
                          //   _buildDestiLocMultiSelectField(),
                          // ]),
                          _buildSourceLocMultiSelectField(),
                          SizedBox(height: 24.h),
                          _buildDestiLocMultiSelectField(),
                          SizedBox(height: 24.h),
                          // Row 5: Category, LR No. (Multi-select)
                          _buildFormRow([
                            _buildCategoryField(),
                            _buildTextField(
                                "Truck Number", _truckNumberController,
                                isRequired: false),
                          ]),
                          SizedBox(height: 24.h),
                          // Row 6: Truck Number
                          // _buildSourceLocMultiSelectField(),

                          SizedBox(height: 40.h),
                          Padding(
                            padding: EdgeInsets.all(20.w),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: _handleSearch,
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40.w, vertical: 16.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.r),
                                    side: BorderSide(
                                        color: Colors.black, width: 1.5),
                                  ),
                                ),
                                child: Text(
                                  "Search",
                                  style: textFieldStyle(
                                    fontSize: 24.sp,
                                    weight: FontWeight.w600,
                                    color: Colors.black,
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
            ],
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

  Widget _buildFormRow(List<Widget> children) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: children.isNotEmpty ? children[0] : SizedBox.shrink(),
          ),
        ),
        Flexible(
          child: children.length > 1 ? children[1] : SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                label,
                style: textFieldStyle(
                  fontSize: 22.sp,
                  weight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isRequired)
              Text(
                " *",
                style: TextStyle(color: Colors.red, fontSize: 22.sp),
              ),
          ],
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 72.h,
          width: double.infinity,
          child: TextFormField(
            controller: controller,
            style: textFieldStyle(
              fontSize: 26.sp,
              weight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.r),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.r),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.r),
                borderSide: BorderSide(color: Colors.grey.shade600, width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                "Insert Date",
                style: textFieldStyle(
                  fontSize: 22.sp,
                  weight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              " *",
              style: TextStyle(color: Colors.red, fontSize: 22.sp),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 72.h,
          width: double.infinity,
          child: TextFormField(
            controller: _insertDateController,
            readOnly: true,
            style: textFieldStyle(
              fontSize: 26.sp,
              weight: FontWeight.w500,
            ),
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (picked != null) {
                setState(() {
                  _insertDateController.text =
                      DateFormat('dd-MMM-yyyy').format(picked);
                });
              }
            },
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.r),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.r),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.r),
                borderSide: BorderSide(color: Colors.grey.shade600, width: 1.5),
              ),
              suffixIcon: Icon(Icons.calendar_today, size: 24.sp),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateComparisonField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                "Date Comparison",
                style: textFieldStyle(
                  fontSize: 22.sp,
                  weight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              " *",
              style: TextStyle(color: Colors.red, fontSize: 22.sp),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        SizedBox(
          // height: 72.h,
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedDateComparison,
                isExpanded: true,
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                style: textFieldStyle(
                  fontSize: 26.sp,
                  weight: FontWeight.w500,
                ),
                items: _dateComparisonOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDateComparison = newValue;
                  });
                },
                icon: Icon(Icons.arrow_drop_down, size: 24.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransporterField() {
    final providerTransporter = Provider.of<TransporterProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Transporter",
          style: textFieldStyle(
            fontSize: 22.sp,
            weight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: double.infinity,
          child: DropdownSearch<TransporterMaster>(
            popupProps: PopupProps.menu(
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                style: textFieldStyle(
                  fontSize: 18.sp,
                  weight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: "Search vehicle...",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.r),
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
                      fontSize: 19.sp,
                      weight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
            items: providerTransporter.transporters,
            itemAsString: (item) => "${item.transCode} - ${item.trnasName}",
            selectedItem: selectedTransport,
            onChanged: (value) {
              setState(() {
                selectedTransport = value;
              });
            },
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_drop_down, size: 22.sp),
                    SizedBox(width: 8.w),
                    Icon(Icons.search, size: 22.sp),
                    SizedBox(width: 8.w),
                    Icon(Icons.add, size: 22.sp),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Category",
          style: textFieldStyle(
            fontSize: 22.sp,
            weight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 10.h),
        SizedBox(
          // height: 72.h,
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCategory,
                isExpanded: true,
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                style: textFieldStyle(
                  fontSize: 26.sp,
                  weight: FontWeight.w500,
                ),
                items: _categoryOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                icon: Icon(Icons.arrow_drop_down, size: 24.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSourceLocMultiSelectField() {
    final providerTransporter =
        Provider.of<TransporterProvider>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Source Loc. ID",
          style: textFieldStyle(
            fontSize: 22.sp,
            weight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 10.h),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: double.infinity,
          ),
          child: ClipRect(
            clipBehavior: Clip.hardEdge,
            child: MultiDropdown<LocationSourceData>(
              items: providerTransporter.sourceLocations
                  .map((loc) => DropdownItem(
                      label: "${loc.code} - ${loc.description}", value: loc))
                  .toList(),
              controller: _sourceLocController,
              enabled: true,
              searchEnabled: true,
              chipDecoration: ChipDecoration(
                backgroundColor: Colors.grey.shade600,
                wrap: true,
                runSpacing: 2.h,
                spacing: 6.w,
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                deleteIcon: Icon(
                  Icons.close,
                  size: 16.sp,
                  color: Colors.white,
                ),
              ),
              fieldDecoration: FieldDecoration(
                hintText: '',
                hintStyle: textFieldStyle(
                  fontSize: 22.sp,
                  weight: FontWeight.w400,
                  color: Colors.grey.shade600,
                ),
                showClearIcon: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.r),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.r),
                  borderSide:
                      BorderSide(color: Colors.grey.shade600, width: 1.5),
                ),
                suffixIcon: Icon(Icons.arrow_drop_down,
                    size: 28.sp, color: Colors.grey.shade700),
              ),
              dropdownDecoration: DropdownDecoration(
                marginTop: 2.h,
                maxHeight: 500.h,
                elevation: 4,
              ),
              dropdownItemDecoration: DropdownItemDecoration(
                selectedIcon: Icon(Icons.check_box,
                    size: 22.sp, color: Color(0xFF21412A)),
                disabledIcon: Icon(Icons.check_box_outline_blank, size: 22.sp),
              ),
              onSelectionChange: (selectedItems) {
                log("Selected Source Locations: $selectedItems");
                setState(() {});
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDestiLocMultiSelectField() {
    final providerTransporter = Provider.of<TransporterProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Destination Loc. ID",
          style: textFieldStyle(
            fontSize: 22.sp,
            weight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 10.h),
        LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              child: MultiDropdown<LocationSourceData>(
                items: providerTransporter.destinationLocations
                    .map((loc) => DropdownItem(
                        label: "${loc.code} - ${loc.description}", value: loc))
                    .toList(),
                controller: _destinationLocController,
                enabled: true,
                searchEnabled: true,
                chipDecoration: ChipDecoration(
                  backgroundColor: Colors.grey.shade600,
                  wrap: true,
                  runSpacing: 2.h,
                  spacing: 6.w,
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  deleteIcon: Icon(
                    Icons.close,
                    size: 16.sp,
                    color: Colors.white,
                  ),
                ),
                fieldDecoration: FieldDecoration(
                  hintText: '',
                  hintStyle: textFieldStyle(
                    fontSize: 22.sp,
                    weight: FontWeight.w400,
                    color: Colors.grey.shade600,
                  ),
                  showClearIcon: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.r),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.r),
                    borderSide:
                        BorderSide(color: Colors.grey.shade600, width: 1.5),
                  ),
                  suffixIcon: Icon(Icons.arrow_drop_down,
                      size: 28.sp, color: Colors.grey.shade700),
                ),
                dropdownDecoration: DropdownDecoration(
                  marginTop: 2.h,
                  maxHeight: 500.h,
                  elevation: 4,
                ),
                onSelectionChange: (selectedItems) {
                  log("Selected LR Numbers: $selectedItems");
                  setState(() {});
                },
              ),
            );
          },
        ),
      ],
    );
  }

  // Widget _buildDestinationLocField() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Destination Loc. ID",
  //         style: textFieldStyle(
  //           fontSize: 22.sp,
  //           weight: FontWeight.w600,
  //         ),
  //       ),
  //       SizedBox(height: 10.h),
  //       SizedBox(
  //         height: 72.h,
  //         width: double.infinity,
  //         child: TextFormField(
  //           controller: _destinationLocIdController,
  //           style: textFieldStyle(
  //             fontSize: 26.sp,
  //             weight: FontWeight.w500,
  //           ),
  //           decoration: InputDecoration(
  //             contentPadding:
  //                 EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(4.r),
  //               borderSide: BorderSide(color: Colors.grey.shade400),
  //             ),
  //             enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(4.r),
  //               borderSide: BorderSide(color: Colors.grey.shade400),
  //             ),
  //             focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(4.r),
  //               borderSide: BorderSide(color: Colors.grey.shade600, width: 1.5),
  //             ),
  //             suffixIcon: Icon(Icons.arrow_drop_down, size: 24.sp),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildCategoryField() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Category",
  //         style: textFieldStyle(
  //           fontSize: 22.sp,
  //           weight: FontWeight.w600,
  //         ),
  //         overflow: TextOverflow.ellipsis,
  //       ),
  //       SizedBox(height: 10.h),
  //       SizedBox(
  //         height: 72.h,
  //         width: double.infinity,
  //         child: Container(
  //           decoration: BoxDecoration(
  //             border: Border.all(color: Colors.grey.shade400),
  //             borderRadius: BorderRadius.circular(4.r),
  //           ),
  //           child: DropdownButtonHideUnderline(
  //             child: DropdownButton<String>(
  //               value: _selectedCategory,
  //               isExpanded: true,
  //               padding: EdgeInsets.symmetric(horizontal: 14.w),
  //               style: textFieldStyle(
  //                 fontSize: 26.sp,
  //                 weight: FontWeight.w500,
  //               ),
  //               hint: Text(
  //                 "",
  //                 style: textFieldStyle(
  //                   fontSize: 26.sp,
  //                   weight: FontWeight.w500,
  //                   color: Colors.grey.shade600,
  //                 ),
  //               ),
  //               items: _categoryOptions.map((String value) {
  //                 return DropdownMenuItem<String>(
  //                   value: value,
  //                   child: Text(value),
  //                 );
  //               }).toList(),
  //               onChanged: (String? newValue) {
  //                 setState(() {
  //                   _selectedCategory = newValue;
  //                 });
  //               },
  //               icon: Icon(Icons.arrow_drop_down, size: 24.sp),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Future<void> _handleSearch() async {
    // Validate required fields
    if (_insertDateController.text.isEmpty) {
      showErrorToast('Please select an Insert Date');
      return;
    }

    if (_selectedDateComparison == null || _selectedDateComparison == 'None') {
      showErrorToast('Please select a Date Comparison');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Convert date from "dd-MMM-yyyy" to "yyyy-MM-dd"
      String formattedDate;
      try {
        final inputDate =
            DateFormat('dd-MMM-yyyy').parse(_insertDateController.text);
        formattedDate = DateFormat('yyyy-MM-dd').format(inputDate);
      } catch (e) {
        showErrorToast('Invalid date format');
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Convert date comparison to API format
      String dateComparisonCode;
      switch (_selectedDateComparison) {
        case 'Before':
          dateComparisonCode = 'BF';
          break;
        case 'After':
          dateComparisonCode = 'AF';
          break;
        case 'Same As':
          dateComparisonCode = 'SM';
          break;
        default:
          dateComparisonCode = 'AF'; // Default to After
      }

      // Get selected source location codes
      final selectedSourceLocs = _sourceLocController.selectedItems
          .map((item) => item.value.code)
          .toList();
      final sourceCodes =
          selectedSourceLocs.isNotEmpty ? selectedSourceLocs.join(',') : null;

      // Get selected destination location codes
      final selectedDestLocs = _destinationLocController.selectedItems
          .map((item) => item.value.code)
          .toList();
      final destinationCodes =
          selectedDestLocs.isNotEmpty ? selectedDestLocs.join(',') : null;

      // Call the search API
      final provider = Provider.of<TransporterProvider>(context, listen: false);
      final success = await provider.searchAllDomesticIndents(
        context,
        date: formattedDate,
        dateComparison: dateComparisonCode,
        source: sourceCodes,
        destination: destinationCodes,
      );

      if (success) {
        log('Search completed successfully. Found ${provider.allIndentsSearchResults.length} results');
        // Navigate to results screen
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AllIndentFilterScreen(),
            ),
          );
        }
      }
    } catch (e) {
      log('Error during search: $e');
      showErrorToast('An error occurred during search');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
