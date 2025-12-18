import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jk_otm/Reusable%20components/text_field.dart';
import 'package:jk_otm/Screens/Transporter/open_indent_screen.dart';
import 'package:jk_otm/utils/image_icon_selector.dart';

class HomepageGrid extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return ShipmentListScreen();
          },
        ));
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
                  child:
                      SvgPicture.asset(ImageIconSelector.getAssetPath(icon))),
              SizedBox(height: 25.h),
              Text(
                description,
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
                summary,
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
