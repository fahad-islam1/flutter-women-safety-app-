// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:women_safety_app/res/colors/colors.dart';
import 'package:women_safety_app/view_model/home_view_model.dart';

class CustomEmergencyComponent extends StatelessWidget {
  const CustomEmergencyComponent({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.number,
    required this.index,
  }) : super(key: key);
  final String image;
  final String title;
  final String subtitle;
  final String number;
  final int index;
  @override
  Widget build(BuildContext context) {
    final homeViewmodel = Get.put(HomeViewModel());

    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        homeViewmodel.switchEmergencyNumber(index);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(8),
          width: size.width * .69,
          // height: 160,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradien)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: white.withOpacity(0.4),
                child: Image.asset(
                  'assets/$image',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                title,
                // 'Active Emergency',
                style: TextStyle(
                    fontSize: size.width * 0.057,
                    fontWeight: FontWeight.bold,
                    color: white),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                subtitle
                // 'Call 0-1-5 for Emergencies'
                ,
                maxLines: 1,
                style: TextStyle(fontSize: size.width * 0.046, color: white),
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: white),
                child: Center(
                  child: Text(
                    number
                    // '0-1-5 '
                    ,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.046,
                        color: Colors.red[300]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
