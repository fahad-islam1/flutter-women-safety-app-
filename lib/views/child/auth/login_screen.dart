import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:women_safety_app/res/colors/colors.dart';
import 'package:women_safety_app/res/components/common/custom_textfield.dart';
import 'package:women_safety_app/res/components/common/primary_button.dart';
import 'package:women_safety_app/res/components/common/secondary_button.dart';
import 'package:women_safety_app/view_model/auth/login_view_model.dart';
import 'package:women_safety_app/views/child/auth/forget_screen.dart';
import 'package:women_safety_app/views/child/auth/register_child_screen.dart';

import '../../parents/register_parent_screen.dart';

import 'package:women_safety_app/res/utils/utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var loginViewModel = Get.put(LoginViewModel());

    return Scaffold(
        body: Obx(
      () => loginViewModel.isLoading.value
          ? loadingIndicator()
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.4,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(height: size.height * 0.1),
                            Text(
                              "USER LOGIN",
                              style: TextStyle(
                                fontSize: size.width * 0.08,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: size.height * 0.06),
                            Image.asset(
                              'assets/logo.png',
                              height: size.width * 0.3,
                              width: size.width * 0.3,
                            ),
                          ],
                        ),
                      ),
                      Form(
                        key: loginViewModel.formkey,
                        child: Column(
                          children: [
                            CustomTextField(
                              hintText: 'Enter email',
                              textInputAction: TextInputAction.next,
                              keyboardtype: TextInputType.emailAddress,
                              prefix: const Icon(Icons.email),
                              validate: (email) {
                                if (email!.isEmpty ||
                                    email.length < 3 && email.contains('@')) {
                                  return 'Enter correct email';
                                }
                                return null;
                              },
                              onsave: (email) {
                                loginViewModel.formdata['email'] = email ?? "";
                              },
                            ),
                            SizedBox(height: size.height * 0.02),
                            CustomTextField(
                              isPassword: !loginViewModel.isPassword.value,
                              hintText: 'Enter password',
                              prefix: const Icon(Icons.lock),
                              validate: (password) {
                                if (password!.isEmpty || password.length < 7) {
                                  return 'Enter correct password';
                                }
                                return null;
                              },
                              onsave: (password) {
                                loginViewModel.formdata['password'] =
                                    password ?? "";
                              },
                              suffix: Obx(
                                () => IconButton(
                                  onPressed: () {
                                    loginViewModel.isPassword.value =
                                        !loginViewModel.isPassword.value;
                                  },
                                  icon: loginViewModel.isPassword.value
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      PrimaryButton(
                        title: 'LOGIN',
                        onPressed: () {
                          loginViewModel.onSaveValue();
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Forgot Password ?",
                            style: TextStyle(fontSize: size.width * 0.04),
                          ),
                          // const SizedBox(width: 10),
                          SecondaryButton(
                              title: 'Click here',
                              onPress: () {
                                Get.to(() => const ForgetScreen());
                              }),
                        ],
                      ),
                      // SizedBox(height: size.height * 0.02),
                      SecondaryButton(
                          title: 'Register as child',
                          onPress: () {
                            Get.off(() => const RegisterChildScreen());
                          }),
                      SecondaryButton(
                          title: 'Register as Parent',
                          onPress: () {
                            Get.off(() => const RegisterParentScreen());

                            // Get.to(() => const RegisterParentScreen());
                          }),
                      SizedBox(
                          height: size.height *
                              0.05), // Add some spacing at the bottom
                    ],
                  ),
                ),
              ),
            ),
    ));
  }
}
