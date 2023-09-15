import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:women_safety_app/res/colors/colors.dart';
import 'package:women_safety_app/res/components/common/custom_textfield.dart';
import 'package:women_safety_app/res/components/common/primary_button.dart';
import 'package:women_safety_app/view_model/accounts_view_model.dart';
import 'package:women_safety_app/view_model/auth/login_view_model.dart';
import 'package:women_safety_app/view_model/chat_view_model.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var chatViewModel = Get.put(ChatViewModel());
    var accountsViewModel = Get.put(AccountsViewModel());

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: 'Logout',
                middleText: 'Are you sure you want to logout?',
                textConfirm: 'Yes',
                textCancel: 'No',
                barrierDismissible: false, // user must tap button!
                confirmTextColor: Colors.white,
                buttonColor: primaryColor,
                onConfirm: () async {
                  Get.put(LoginViewModel()).signOut();
                },
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        automaticallyImplyLeading: true,
        backgroundColor: primaryColor,
        title: const Text(
          'Accounts ',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2.0),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * .08,
              ),
              InkWell(
                onTap: () async {
                  await accountsViewModel.selectImage(ImageSource.gallery);
                },
                child: Obx(
                  () => Stack(
                    children: [
                      accountsViewModel.imagePath.isNotEmpty
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: size.width * .2,
                              backgroundImage: FileImage(
                                File(accountsViewModel.imagePath.value),
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: size.width * .2,
                              backgroundImage: NetworkImage(
                                  accountsViewModel.imageUrls.value),
                            ),
                      Positioned(
                        bottom: -2,
                        right: -2,
                        child: IconButton(
                          onPressed: () async {
                            await accountsViewModel
                                .selectImage(ImageSource.gallery);
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .04,
              ),
              CustomTextField(
                controller: accountsViewModel.name,
                hintText: chatViewModel.name.value,
                textInputAction: TextInputAction.next,
                keyboardtype: TextInputType.emailAddress,
                prefix: const Icon(Icons.person),
                validate: (email) {
                  if (email!.isEmpty ||
                      email.length < 3 && email.contains('@')) {
                    return 'Enter correct email';
                  }
                  return null;
                },
                onsave: (email) {
                  // loginViewModel.formdata['email'] = email ?? "";
                },
              ),
              SizedBox(
                height: size.height * .05,
              ),
              SizedBox(
                  width: size.width * .4,
                  child: PrimaryButton(
                      title: "Update",
                      onPressed: () async {
                        if (accountsViewModel.imagePath.isNotEmpty) {
                          await accountsViewModel
                              .uploadImage(); // This should update `imageUrl` in AccountsViewModel
                        }

                        await accountsViewModel
                            .updateProfile(); // This will update name and/or image URL as required
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
