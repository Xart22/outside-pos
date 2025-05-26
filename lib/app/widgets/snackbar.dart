import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackbar(String title, String message) {
  return Get.snackbar(title, message,
      backgroundColor: const Color(0xff121212),
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.info, color: Colors.white),
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.BOTTOM);
}
