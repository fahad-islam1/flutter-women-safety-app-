import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:women_safety_app/res/components/common/custom_textfield.dart';
import 'package:women_safety_app/res/components/common/primary_button.dart';
import 'package:women_safety_app/res/utils/utils.dart';
import 'package:women_safety_app/view_model/auth/forget_pass_viewModel.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var forgetpassViewModel = Get.put(ForgetPassViewwModel());

    return Scaffold(
      body: Obx(
        () => forgetpassViewModel.isLoading.value
            ? loadingIndicator()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.19),
                      Image.asset(
                        'assets/logo.png',
                        height: size.width * 0.5,
                        width: size.width * 0.5,
                      ),
                      SizedBox(height: size.height * 0.02),
                      CustomTextField(
                        controller: forgetpassViewModel.email,
                        hintText: 'Enter registered  email',
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
                      ),
                      SizedBox(height: size.height * 0.02),
                      PrimaryButton(
                          title: 'Forget Password',
                          onPressed: () {
                            if (forgetpassViewModel.email.text.isNotEmpty) {
                              forgetpassViewModel.forgetPassword(
                                  forgetpassViewModel.email.text);
                            }
                          })
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
