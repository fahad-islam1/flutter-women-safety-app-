import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/res/colors/colors.dart';
import 'package:women_safety_app/res/const/firebase_const.dart';
import 'package:women_safety_app/view_model/auth/login_view_model.dart';
import 'package:women_safety_app/view_model/chat_view_model.dart';
import 'package:women_safety_app/views/child/accounts/accounts_screen.dart';

Drawer parentDrawer(
    Size size, ChatViewModel chatViewModel, LoginViewModel loginModel) {
  return Drawer(
    width: size.width * 0.69,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: primaryColor,
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/logo.png',
                height: size.width * 0.25,
                width: size.width * 0.35,
                color: white,
              ),
              const SizedBox(
                height: 5,
              ),
              const Flexible(
                child: Text(
                  'Women Safety App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(
            chatViewModel.name.value.toString(),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          onTap: () {
            chatViewModel.getstatus();
          },
        ),
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text(
            'Accounts',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          onTap: () {
            Get.to(() => const AccountScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.email),
          title: Text(auth.currentUser!.email!,
              style: const TextStyle(
                fontSize: 16,
              )),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Sign out'),
          onTap: () {
            loginModel.signOut();
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('Version 1.1'),
          onTap: () {},
        ),
      ],
    ),
  );
}
