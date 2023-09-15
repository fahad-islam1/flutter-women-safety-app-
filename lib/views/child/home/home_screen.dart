import 'package:flutter/material.dart';
import 'package:women_safety_app/res/components/emergency/emergency.dart';
import 'package:women_safety_app/res/components/home/custom_slider.dart';
import 'package:women_safety_app/res/components/life_safe/explore_life_save.dart';
import 'package:women_safety_app/res/components/share_location/share_location.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final homeViewmodel = Get.put(HomeViewModel());
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Obx(
            //   () => CustomAppbar(
            //     onTap: () {
            //       homeViewmodel.getrandom();
            //     },
            //     index: homeViewmodel.appbarIndex.value,
            //   ),
            // ),

            const CustomSlider(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
              child: Text(
                'Emergency',
                style: TextStyle(
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ),
            const EmergencyCard(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
              child: Text(
                'Explore Life Safe',
                style: TextStyle(
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ),
            const ExploreLifeSafe(),
            const ShareLocation()
          ],
        ),
      )),
    );
  }
}
