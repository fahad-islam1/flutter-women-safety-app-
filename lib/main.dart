import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety_app/data/background/background_services.dart';
import 'package:women_safety_app/data/shared_preferences/shared_preferences.dart';
import 'package:women_safety_app/model/contact_model.dart';
import 'package:women_safety_app/res/utils/utils.dart';
import 'package:women_safety_app/views/child/bottom_nav_bar.dart';
import 'package:women_safety_app/views/child/auth/login_screen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:women_safety_app/views/parents/parent_home_screen.dart';

import 'firebase_options.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MySharedPrefernces.init();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  // Register  adapter
  Hive.registerAdapter(ContactModelAdapter());
  await Hive.openBox<ContactModel>('contactsData');

  await initiallizedLocalNotification();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Woman Safety App',
      theme: ThemeData(
        textTheme: GoogleFonts.figtreeTextTheme(ThemeData.light().textTheme),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
      home: FutureBuilder(
        future: MySharedPrefernces.getUserType(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingIndicator();
          }

          switch (snapshot.data) {
            case '':
              return const LoginScreen();
            case 'child':
              return const BottomNavPagesScreen();
            case 'parent':
              return const ParentHomeScreen();
            default:
              return const LoginScreen();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
