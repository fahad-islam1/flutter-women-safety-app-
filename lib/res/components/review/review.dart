import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/res/components/common/custom_textfield.dart';
import 'package:women_safety_app/res/components/common/primary_button.dart';
import 'package:women_safety_app/res/utils/utils.dart';
import 'package:women_safety_app/view_model/review_model.dart';

void addReviews(ReviewViewModel reviewViewModel) {
  Get.defaultDialog(
    contentPadding: EdgeInsets.zero,
    title: "Add Review",
    content: Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          CustomTextField(
            hintText: 'Location',
            controller: reviewViewModel.location,
          ),

          const Divider(), // Add a divider for better separation
          CustomTextField(
            hintText: 'Review',
            controller: reviewViewModel.review,
          ),
          const Divider(), // Add a divider for better separation

          PrimaryButton(
            title: 'Add Review',
            onPressed: () {
              if (reviewViewModel.location.text.isNotEmpty &&
                  reviewViewModel.review.text.isNotEmpty) {
                reviewViewModel
                    .addReviews(
                        location: reviewViewModel.location.text,
                        review: reviewViewModel.review.text)
                    .then((value) {
                  reviewViewModel.location.text = '';
                  reviewViewModel.review.text = '';
                  Get.back();
                });
              } else {
                showError("Please fill all the fields");
              }
            },
          ),

          // PrimaryButton(
          //   title: 'Cancel',
          //   onPressed: () {
          //     Get.back();
          //   },
          // ),
        ],
      ),
    ),
    // confirm:
  );
}
