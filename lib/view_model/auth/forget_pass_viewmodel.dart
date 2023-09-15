import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/res/utils/utils.dart';

import '../../res/const/firebase_const.dart';

class ForgetPassViewwModel extends GetxController {
  var isLoading = false.obs;
  var email = TextEditingController();

  Future forgetPassword(String email) async {
    try {
      isLoading(true);
      await auth.sendPasswordResetEmail(email: email).then((value) {
        Get.back();
        showSuccess('Reset password link has been sent to your email', "");
      });
    } catch (e) {
      isLoading(false);
      showError(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
