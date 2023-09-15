import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/res/const/firebase_const.dart';
import 'package:women_safety_app/views/child/home/home_screen.dart';
import 'package:women_safety_app/views/child/auth/login_screen.dart';
import 'package:women_safety_app/views/parents/parent_home_screen.dart';

class SplashScreenMethod {
  void startTimer(BuildContext context) {
    Timer(const Duration(seconds: 2), () async {
      if (auth.currentUser == null) {
        Get.off(() => const LoginScreen());
      } else {
         firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get()
            .then((value) {
          if (value['type'] == 'parent') {
            Get.off(() => const ParentHomeScreen());
          } else {
            Get.off(() => const HomeScreen());
          }
        });
      }
    });
  }
}
