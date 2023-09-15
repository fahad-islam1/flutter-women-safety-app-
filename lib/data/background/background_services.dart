import 'dart:async';
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:shake/shake.dart';
import 'package:telephony/telephony.dart';
import 'package:vibration/vibration.dart';
import 'package:women_safety_app/data/hive%20db/boxes.dart';
import 'package:women_safety_app/model/contact_model.dart';
import 'package:women_safety_app/res/utils/utils.dart';

sendMessage(String messageBody) async {
await Hive.openBox<ContactModel>('contactsData');
  final contactBox = Boxes.getContacts();
  final contactList = contactBox.values.toList();

  if (contactList.isEmpty) {
    showError('no number exist please add a number');
  } else {
    for (var i = 0; i < contactList.length; i++) {
  Telephony.backgroundInstance
      .sendSms(to: contactList[i].phoneNumber, message: messageBody)
      .then((value) {
    showSuccess('Message send successfully', "");
  });
}
  }
}

Future<void> initiallizedLocalNotification() async {
  final service = FlutterBackgroundService();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestPermission();

  AndroidNotificationChannel androidNotificationChannel =
      const AndroidNotificationChannel(
    'Fahad Tech',
    'ForegroundServices',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .createNotificationChannel(androidNotificationChannel);

  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,

      notificationChannelId:
          'Fahad Tech', // this must match with notification channel  created above.
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 12,
    ),
  );
  service.startService();
}

@pragma('vm-entry-point')
void onStart(ServiceInstance service) async {
  // Initialize Hive in the background service
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  DartPluginRegistrant.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Position? curentPosition;
  if (service is AndroidServiceInstance) {
    ShakeDetector.autoStart(
      shakeThresholdGravity: 7,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      minimumShakeCount: 1,
      onPhoneShake: () async {
        if (await Vibration.hasVibrator() ?? false) {
          if (await Vibration.hasCustomVibrationsSupport() ?? false) {
            Vibration.vibrate(duration: 1000);
          } else {
            Vibration.vibrate();
            await Future.delayed(const Duration(milliseconds: 500));
            Vibration.vibrate();
          }
        }
        await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          forceAndroidLocationManager: true,
        ).then((Position position) {
          curentPosition = position;
        }).catchError((e) {
          showError(e.toString());
        });

        // Show the notification here when a shake is detected
        flutterLocalNotificationsPlugin.show(
          888,
          "women safety app",
          "Shake feature enabled",
          const NotificationDetails(
            android: AndroidNotificationDetails(
              "script academy",
              "foreground service",
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );

        // Create and send the message here
        String messageBody =
            "https://www.google.com/maps/search/?api=1&query=${curentPosition!.latitude}%2C${curentPosition!.longitude}";

        sendMessage(messageBody);
      },
    );
  }
}
