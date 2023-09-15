import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/data/shared_preferences/shared_preferences.dart';
import 'package:women_safety_app/res/const/firebase_const.dart';
import 'package:women_safety_app/res/utils/utils.dart';
import 'package:women_safety_app/views/child/auth/login_screen.dart';
import 'package:women_safety_app/views/child/bottom_nav_bar.dart';
import 'package:women_safety_app/views/parents/parent_home_screen.dart';

class LoginViewModel extends GetxController {
  var isPassword = false.obs;
  var isLoading = false.obs;

  final formkey = GlobalKey<FormState>();
  final formdata = <String, Object>{};

  onSaveValue() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      try {
        isLoading(true);
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: formdata['email'].toString(),
            password: formdata['password'].toString());

        if (userCredential.user != null) {
          firestore
              .collection(usercollection)
              .doc(auth.currentUser!.uid)
              .get()
              .then((value) {
            if (value.exists) {
              if (value['type'] == 'child') {
                MySharedPrefernces.userSaveType('child');
                Get.off(() => const BottomNavPagesScreen());
              } else {
                MySharedPrefernces.userSaveType('parent');
                Get.off(() => const ParentHomeScreen());
              }
            } else {
              showError('No user found for that email.');
            }
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showError('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          showError('Wrong password provided for that user.');
        } else if (e.code == 'invalid-email') {
          showError('Invalid email format.');
        } else {
          showError('An error occurred while logging in.');
        }
        isLoading(false);
      } catch (error) {
        isLoading(false);
        showError(error.toString());
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
    MySharedPrefernces.userSaveType('');
    Get.offAll(() => const LoginScreen());
  }
}
