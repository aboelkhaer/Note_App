import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomFullScreenDialog {
  static void showDialog() {
    Get.dialog(
      WillPopScope(
        child: Container(
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        onWillPop: () => Future.value(true),
      ),
      barrierDismissible: false,
      barrierColor: const Color(0xFF141A31).withOpacity(0.3),
      useSafeArea: true,
    );
  }

  static void cancelDialog() {
    Get.back();
  }
}
