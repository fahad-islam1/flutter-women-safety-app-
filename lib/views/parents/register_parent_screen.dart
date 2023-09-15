import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/res/utils/utils.dart';

import 'package:women_safety_app/res/colors/colors.dart';
import 'package:women_safety_app/res/components/common/custom_textfield.dart';
import 'package:women_safety_app/res/components/common/primary_button.dart';
import 'package:women_safety_app/res/components/common/secondary_button.dart';
import 'package:women_safety_app/view_model/auth/register_view_model.dart';
import 'package:women_safety_app/views/child/auth/login_screen.dart';

class RegisterParentScreen extends StatelessWidget {
  const RegisterParentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final registerViewModel = Get.put(RegisterViewModel());

    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => registerViewModel.isLoading.value
              ? loadingIndicator()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            // height: size.height * 0.4,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // SizedBox(height: size.height * 0.1),
                                Text(
                                  "Register as  Parent",
                                  style: TextStyle(
                                    fontSize: size.width * 0.09,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.01),

                                Image.asset(
                                  'assets/logo.png',
                                  height: size.width * 0.3,
                                  width: size.width * 0.3,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          Form(
                            key: registerViewModel.formkey1,
                            child: Column(
                              children: [
                                CustomTextField(
                                  hintText: 'Enter Name',
                                  textInputAction: TextInputAction.next,
                                  keyboardtype: TextInputType.text,
                                  prefix: const Icon(Icons.person),
                                  validate: (name) {
                                    if (name!.isEmpty || name.length < 3) {
                                      return 'Enter correct Name';
                                    }
                                    return null;
                                  },
                                  onsave: (name) {
                                    registerViewModel.formdata['name'] =
                                        name ?? "";
                                  },
                                ),
                                SizedBox(height: size.height * 0.02),
                                CustomTextField(
                                  hintText: 'Enter Phone',
                                  textInputAction: TextInputAction.next,
                                  keyboardtype: TextInputType.phone,
                                  prefix:
                                      const Icon(Icons.phone_android_rounded),
                                  validate: (name) {
                                    if (name!.isEmpty || name.length < 8) {
                                      return 'Enter correct Phone';
                                    }
                                    return null;
                                  },
                                  onsave: (phone) {
                                    registerViewModel.formdata['phone'] =
                                        phone ?? "";
                                  },
                                ),
                                SizedBox(height: size.height * 0.02),
                                CustomTextField(
                                  hintText: 'Enter email',
                                  textInputAction: TextInputAction.next,
                                  keyboardtype: TextInputType.emailAddress,
                                  prefix: const Icon(Icons.email),
                                  validate: (gemail) {
                                    if (gemail!.isEmpty ||
                                        gemail.length < 3 &&
                                            gemail.contains('@')) {
                                      return 'Enter correct email';
                                    }
                                    return null;
                                  },
                                  onsave: (gemail) {
                                    registerViewModel.formdata['gemail'] =
                                        gemail ?? "";
                                  },
                                ),
                                SizedBox(height: size.height * 0.02),
                                CustomTextField(
                                  hintText: 'Enter child email',
                                  textInputAction: TextInputAction.next,
                                  keyboardtype: TextInputType.emailAddress,
                                  prefix: const Icon(Icons.email),
                                  validate: (email) {
                                    if (email!.isEmpty ||
                                        email.length < 3 &&
                                            email.contains('@')) {
                                      return 'Enter correct child email';
                                    }
                                    return null;
                                  },
                                  onsave: (email) {
                                    registerViewModel.formdata['email'] =
                                        email ?? "";
                                  },
                                ),
                                SizedBox(height: size.height * 0.02),
                                CustomTextField(
                                  hintText: 'Enter password',
                                  isPassword:
                                      registerViewModel.isPassword.value,
                                  prefix: const Icon(Icons.lock),
                                  validate: (password) {
                                    if (password!.isEmpty ||
                                        password.length < 7) {
                                      return 'Enter correct password';
                                    }
                                    return null;
                                  },
                                  onsave: (password) {
                                    registerViewModel.formdata['password'] =
                                        password ?? "";
                                  },
                                  suffix: IconButton(
                                    onPressed: () {
                                      registerViewModel.isPassword.value =
                                          !registerViewModel.isPassword.value;
                                    },
                                    icon: registerViewModel.isPassword.value
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.02),
                                CustomTextField(
                                  hintText: 'Enter Confirm password',
                                  isPassword:
                                      registerViewModel.isCPassword.value,
                                  prefix: const Icon(Icons.lock),
                                  validate: (confirm) {
                                    if (confirm!.isEmpty ||
                                        confirm.length < 7) {
                                      return 'Enter correct password';
                                    }
                                    return null;
                                  },
                                  onsave: (cpassword) {
                                    registerViewModel.formdata['cpassword'] =
                                        cpassword ?? "";
                                  },
                                  suffix: IconButton(
                                    onPressed: () {
                                      registerViewModel.isCPassword.value =
                                          !registerViewModel.isCPassword.value;
                                    },
                                    icon: registerViewModel.isCPassword.value
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          PrimaryButton(
                              title: 'Register',
                              onPressed: () {
                                // loadingIndicator(context);
                                registerViewModel.signUp('parent');
                              }),
                          SizedBox(height: size.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(fontSize: size.width * 0.04),
                              ),
                              // const SizedBox(width: 10),
                              SecondaryButton(
                                  title: 'Login',
                                  onPress: () {
                                    Get.off(() => const LoginScreen());
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
