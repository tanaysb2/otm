import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jk_otm/Providers/transporter_provider.dart';
import 'package:jk_otm/Reusable%20components/text_field.dart';
import 'package:jk_otm/Screens/Transporter/all_indent_screen.dart';
import 'package:jk_otm/Screens/Transporter/assign_truck_screen.dart';
import 'package:jk_otm/Screens/Transporter/open_indent_screen.dart';
import 'package:jk_otm/utils/image_icon_selector.dart';
import 'package:provider/provider.dart';

class HomepageGrid extends StatefulWidget {
  final String icon;
  final String description;
  final String summary;

  const HomepageGrid({
    Key? key,
    required this.icon,
    required this.description,
    required this.summary,
  }) : super(key: key);

  @override
  State<HomepageGrid> createState() => _HomepageGridState();
}

class _HomepageGridState extends State<HomepageGrid> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransporterProvider>(context, listen: false)
        .fetchSourceLocations(context)
        .then((value) {
      Provider.of<TransporterProvider>(context, listen: false)
          .fetchDestinationLoc(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.description == "OPEN INDENT") {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return ShipmentListScreen();
            },
          ));
        } else if (widget.description == "ASSIGN TRUCK") {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return AssignTruckListScreen();
            },
          ));
        } else if (widget.description == "ALL INDENT") {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return AllIndentListScreen();
            },
          ));
        } else {
          
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        elevation: 2,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  child: SvgPicture.asset(
                      ImageIconSelector.getAssetPath(widget.icon))),
              SizedBox(height: 25.h),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: textFieldStyle(
                  fontSize: 25.sp,
                  weight: FontWeight.bold,
                  spacing: 0.7,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                widget.summary,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: textFieldStyle(
                  color: Colors.grey.shade700,
                  fontSize: 24.sp,
                  weight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
