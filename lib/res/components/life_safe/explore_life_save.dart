import 'package:flutter/material.dart';
import 'package:women_safety_app/res/components/life_safe/custom_components.dart';

class ExploreLifeSafe extends StatelessWidget {
  const ExploreLifeSafe({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: const [
          CustomComponeentsLifeSafe(
            title: 'Police Stations',
            image: 'police-badge.png',
            index: 1,
          ),
          CustomComponeentsLifeSafe(
            title: 'Hospitals',
            index: 2,
            image: 'hospital.png',
          ),
          CustomComponeentsLifeSafe(
            title: 'Pharmacy',
            image: 'pharmacy.png',
            index: 3,
          ),
          CustomComponeentsLifeSafe(
            title: 'Bus Stations',
            image: 'bus-stop.png',
            index: 4,
          ),
        ],
      ),
    );
  }
}
