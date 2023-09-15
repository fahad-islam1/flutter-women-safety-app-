import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/model/child_user_model.dart';
import 'package:women_safety_app/res/const/firebase_const.dart';

import 'package:women_safety_app/views/child/auth/login_screen.dart';

class RegisterViewModel extends GetxController {
  var isPassword = true.obs;
  var isCPassword = true.obs;
  var isLoading = false.obs;

  final formkey1 = GlobalKey<FormState>();
  final formdata = <String, Object>{};

  Future<void> signUp(String usertype) async {
    if (formkey1.currentState!.validate()) {
      formkey1.currentState!.save();

      if (formdata['password'] != formdata['cpassword']) {
        showError('Confirm password does not match');
      } else {
        try {
          isLoading(true);

          await auth
              .createUserWithEmailAndPassword(
                  email: usertype == 'child'
                      ? formdata['email'].toString()
                      : formdata['gemail'].toString(),
                  password: formdata['password'].toString())
              .then((val) async {
            var db = firestore.collection(usercollection).doc(val.user!.uid);
            UserModel usermodel = UserModel(
                name: formdata['name'].toString(),
                phone: formdata['phone'].toString(),
                childemail: formdata['email'].toString(),
                type: usertype,
                imageUrl:
                    'https://static-00.iconduck.com/assets.00/profile-circle-icon-2048x2048-cqe5466q.png',
                parentemail: formdata['gemail'].toString(),
                id: auth.currentUser!.uid);

            await db.set(usermodel.toJson()).whenComplete(() {
              Get.off(() => const LoginScreen());
              isLoading(false);
            });
          });
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            showError('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            showError('The account already exists for that email.');
          }
          isLoading(false);
        } catch (error) {
          isLoading(false);
          showError(error.toString());
        } finally {
          isLoading(
              false); // Ensure isLoading is reset regardless of success or failure
        }
      }
    }
  }

  void showError(String message) {
    Get.snackbar('Error', message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white);
  }
}
