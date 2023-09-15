import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:women_safety_app/res/colors/colors.dart';
import 'package:women_safety_app/view_model/home_view_model.dart';

class CustomComponeentsLifeSafe extends StatelessWidget {
  const CustomComponeentsLifeSafe({
    Key? key,
    required this.image,
    required this.title,
    required this.index,
  }) : super(key: key);
  final String image;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    final homeViewmodel = Get.put(HomeViewModel());

    return InkWell(
      onTap: () {
        homeViewmodel.switchEmergencyLocation(index);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
        child: Column(
          children: [
            Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Center(
                      child: Image.asset(
                    'assets/$image',
                    height: 50,
                  )),
                )),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  // fontWeight: FontWeight.bold,
                  color: black),
            ),
          ],
        ),
      ),
    );
  }
}
