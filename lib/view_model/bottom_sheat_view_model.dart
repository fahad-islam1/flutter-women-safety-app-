import 'package:get/get.dart';
import 'package:background_sms/background_sms.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:women_safety_app/data/hive%20db/boxes.dart';

import 'package:women_safety_app/res/utils/utils.dart';

class BottomSheetControllers extends GetxController {
  Position? currentPosition;
  String? currentAddress = '';
  LocationPermission? permission;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  sendMsg(String phoneNumber, String msg, {int? sim}) async {
    var result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: msg, simSlot: sim);
    if (result == SmsStatus.sent) {
      showSuccess('Message sent', "");
    } else {
      showError('Failed to send');
    }
  }

  void openLocationSettings() {
    Geolocator.openLocationSettings();
  }

  requestPermissions() async {
    await Permission.location.request();
    await Permission.sms.request();
  }

  grantedPermission() async {
    return await Permission.sms.status.isGranted;
  }

  getCurrentLocation() async {
    requestPermissions();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    try {
      currentPosition = await Geolocator.getCurrentPosition(
          forceAndroidLocationManager: true,
          desiredAccuracy: LocationAccuracy.high);

      if (currentPosition != null) {
        getCurrentAddress();
        update();
      } else {
        showError('Failed to obtain position, currentPosition is null.');
      }
    } catch (e) {
      openLocationSettings();
      showError('Failed to get current position: $e');
    }
  }

  getCurrentAddress() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition!.latitude, currentPosition!.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        currentAddress =
            "${place.locality}, ${place.street}, ${place.postalCode}, ${place.name}, ${place.subAdministrativeArea}";
      } else {
        // Handle case where no results were found
        showError('No address found for the given coordinates.');
      }

      update();
    } catch (e) {
      // Handle any other errors that may occur
      showError('Failed to get current address: $e');
    }
  }

  sendLocation() async {
    // Request SMS permission
    // await requestPermissions();

    final contactBox = Boxes.getContacts();
    if (contactBox == null || contactBox.isEmpty) {
      showError('No contacts available to send location');
      return;
    }

    String msgBody =
        // "https://maps.google.com/?daddr=${currentPosition!.latitude},${currentPosition!.longitude}";
        "https://maps.google.com/?daddr=${currentPosition!.latitude},${currentPosition!.longitude}  ,  $currentAddress";

    final contactList = contactBox.values.toList();
    List<Future> smsSendingTasks = [];

    if (await grantedPermission()) {
      for (var element in contactList) {
        smsSendingTasks
            .add(sendMsg(element.phoneNumber, "I am in trouble $msgBody"));
      }

      try {
        await Future.wait(smsSendingTasks);
        showSuccess('All messages sent successfully', '');
      } catch (e) {
        showError('Failed to send some messages: $e');
      }
    }
  }
}
