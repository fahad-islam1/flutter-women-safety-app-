
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/res/components/common/primary_button.dart';
import 'package:women_safety_app/res/utils/utils.dart';
import 'package:women_safety_app/view_model/bottom_sheat_view_model.dart';

showBottomSheets(BuildContext context) {
  final BottomSheetControllers controller = Get.put(BottomSheetControllers());

  Get.bottomSheet(
    Container(
      height: MediaQuery.of(context).size.height * .42,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Send Your Current Location To Emergency Contacts',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(
            height: 20,
          ),
          if (controller.currentPosition != null)
            Text('${controller.currentAddress}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black)),
          const SizedBox(
            height: 20,
          ),
          PrimaryButton(
            title: 'Get Location',
            onPressed: () {
              controller.getCurrentLocation();

      
              showLocationDialog(
                  controller.currentAddress, controller.currentPosition);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          PrimaryButton(
            title: 'Send Location',
            onPressed: () {
              controller.sendLocation();

              // Get.back();
            },
          )
        ],
      ),
    ),
  );
}
