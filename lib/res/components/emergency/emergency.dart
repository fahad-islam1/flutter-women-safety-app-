import 'package:flutter/material.dart';
import 'package:women_safety_app/res/components/emergency/custom_emergency_componenet.dart';

class EmergencyCard extends StatelessWidget {
  const EmergencyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        height: 190,
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          children: const [
            CustomEmergencyComponent(
              image: 'alert.png',
              subtitle: 'Call 0-1-5 for Emergencies',
              title: 'Active Emergency',
              number: '0-1-5',
              index: 1,
            ),
            CustomEmergencyComponent(
              image: 'ambulance.png',
              subtitle: 'In the case of Medical Emergencies',
              title: 'Ambulance',
              number: '1-1-2-2',
              index: 2,
            ),
            CustomEmergencyComponent(
              image: 'flame.png',
              subtitle: 'In the case of Fire Emergencies',
              title: 'Fire Brigade',
              number: '0-1-6',
              index: 3,
            ),
            CustomEmergencyComponent(
              image: 'army.png',
              subtitle: 'National counter Terrorism Authority',
              title: 'NCTA',
              number: '1-7-1-7',
              index: 4,
            ),
          ],
        ),
      ),
    );
  }
}
