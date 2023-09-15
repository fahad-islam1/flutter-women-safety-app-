import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/res/colors/colors.dart';

Widget loadingIndicator() {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: primaryColor,
      color: Colors.red,
      strokeWidth: 7,
    ),
  );
}

showError(message) {
  Get.snackbar("Error", message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM);
}

showSuccess(title, message) {
  Get.snackbar(
      title,
      // "Sign-up successful!",
      message,
      backgroundColor: Colors.white,
      colorText: Colors.black,
      snackPosition: SnackPosition.BOTTOM);
}

void showAlertDialog(title, msg) {
  Get.defaultDialog(
    title: title,
    content: Text(msg),
    confirm: ElevatedButton(
      onPressed: () {
        Get.back(); // Close the dialog
      },
      child: Text("OK"),
    ),
  );
}

void showLocationDialog(currentAddress, currentPosition) {
  Get.defaultDialog(
    contentPadding: EdgeInsets.zero,
    title: "Location Information",
    content: Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 18, color: Colors.black),
              children: [
                const TextSpan(
                  text: "Address: ",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.blue),
                ),
                TextSpan(
                  text: "$currentAddress",
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              children: [
                const TextSpan(
                  text: "Latitude: ",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.blue),
                ),
                TextSpan(
                  text: "${currentPosition?.latitude}",
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              children: [
                const TextSpan(
                  text: "Longitude: ",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.blue),
                ),
                TextSpan(
                  text: "${currentPosition?.longitude}",
                ),
              ],
            ),
          ),
          const Divider(), // Add a divider for better separation
        ],
      ),
    ),
    confirm: ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: primaryColor ),
      onPressed: () {
        Get.back(); // Close the dialog
      },
      child: const Text(
        "OK",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    ),
  );
}
