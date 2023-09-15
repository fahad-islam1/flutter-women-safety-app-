import 'dart:io';
import 'dart:math';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:women_safety_app/view_model/bottom_sheat_view_model.dart';
import 'package:women_safety_app/view_model/chat_view_model.dart';

class HomeViewModel extends GetxController {
  var appbarIndex = 0.obs;

  @override
  void onInit() {
    Get.put(ChatViewModel()).getstatus();
    controller.requestPermissions();
    controller.getCurrentLocation();
    super.onInit();
  }

  var controller = Get.put(BottomSheetControllers());

// getrandom
  getrandom() {
    Random random = Random();

    appbarIndex.value = random.nextInt(6);
  }

// call emergency numbers

  callNumber(number) async {
    return await FlutterPhoneDirectCaller.callNumber(number);
  }

// switchEmergencyNumber
  switchEmergencyNumber(index) {
    switch (index) {
      case 1:
        callNumber('015');

        break;
      case 2:
        callNumber('1122');

        break;
      case 3:
        callNumber('016');

        break;
      case 4:
        callNumber('1717');

        break;
    }
  }

  Future<void> launchUrls(String location) async {
    String googleUrl = 'https://www.google.com/maps/search/$location';

    if (Platform.isAndroid) {
      if (await canLaunchUrl(Uri.parse(googleUrl))) {
        await launchUrl(Uri.parse(googleUrl));
      } else {
        throw 'Could not launch $googleUrl';
      }
    }
  }

 
// switchEmergencyLocation
  switchEmergencyLocation(index) {
    switch (index) {
      case 1:
        launchUrls('police+station+near+me');

        break;
      case 2:
        launchUrls('Hospital+near+me');

        break;
      case 3:
        launchUrls('pharmacy+near+me');

        break;
      case 4:
        launchUrls('bus+station+near+me');

        break;
    }
  }
}

  // shakePhone() {
  //   ShakeDetector detector = ShakeDetector.autoStart(
  //     onPhoneShake: () {
  //       showSuccess('sent', 'Message sent successfully');
  //       controller.sendLocation();
  //     },
  //     minimumShakeCount: 1,
  //     shakeSlopTimeMS: 500,
  //     shakeCountResetTime: 3000,
  //     shakeThresholdGravity: 2.7,
  //   );
  // }

