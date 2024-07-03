import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'app_colors.dart';

abstract class AppUtils {
  static showToast(
      BuildContext context, String title, String description, bool isError) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 4),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'MontserratMedium',
          fontSize: MediaQuery.sizeOf(context).width * 0.05,
          color: AppColors.appColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(
        description,
        style: TextStyle(
          fontFamily: 'MontserratMedium',
          fontSize: MediaQuery.sizeOf(context).width * 0.03,
          color: AppColors.appColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      icon: isError
          ? const Icon(
        Icons.cancel_outlined,
        color: AppColors.warningColor,
        size: 30,
      )
          : const Icon(
        Icons.check,
        color: AppColors.appColor,
        size: 30,
      ),
      primaryColor: AppColors.appColor,
      backgroundColor: Colors.white,
      foregroundColor: AppColors.appColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Colors.transparent,
          blurRadius: 0,
          offset: Offset(0, 0),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      progressBarTheme: ProgressIndicatorThemeData(
          color: isError ? AppColors.warningColor : Colors.green),
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
    );
  }
}
