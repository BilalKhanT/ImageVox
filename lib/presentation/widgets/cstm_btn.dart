import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../config/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color btnColor;
  final double width;
  final String svgPath;
  final Color color;
  final double padding;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.btnColor,
    required this.width,
    required this.svgPath,
    required this.color,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              offset: const Offset(1, 1),
              blurRadius: 15,
              color: AppColors.textColor.withOpacity(0.66),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Row(
            children: [
              SvgPicture.asset(
                svgPath,
                // ignore: deprecated_member_use
                color: color,
                height: 30,
                width: 30,
              ),
              SizedBox(
                width: padding,
              ),
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'MontserratMedium',
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w800,
                  color: color,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
