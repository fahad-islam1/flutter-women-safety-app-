import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/view_model/home_view_model.dart';
import 'package:women_safety_app/views/child/accounts/accounts_screen.dart';
import 'package:women_safety_app/views/child/chat/select_guardin_screen.dart';
import 'package:women_safety_app/views/child/home/home_screen.dart';
import 'package:women_safety_app/views/child/review/review_screen.dart';

import '../views/child/contact/add_contact.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;

  @override
  void dispose() {
    // Get.delete<HomeViewModel>(); // Dispose of the ViewModel
    super.dispose();
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    HapticFeedback.lightImpact();
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.contacts,
    Icons.chat,
    Icons.reviews,
    Icons.person_rounded,
  ];

  List<String> listOfStrings = [
    'Home',
    'Contact',
    'Chat',
    'Review',
    'Account',
  ];

  List<Widget> pages = const [
    HomeScreen(),
    AddContacts(),
    ParentListScreen(),
    ReviewScreen(),
    AccountScreen()
  ];
  
}
