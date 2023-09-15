import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/data/services/review_services.dart';
import 'package:women_safety_app/res/utils/utils.dart';

class ReviewViewModel extends GetxController {
  var location = TextEditingController();
  var review = TextEditingController();

  final ReviewServices reviewServices = ReviewServices();

  Future addReviews({String? location, String? review}) async {
    try {
      return reviewServices.addReviews(location: location, review: review);
    } catch (e) {
      showError(e.toString());
    }
  }

  Stream<QuerySnapshot> getReviews() {
    try {
      return reviewServices.getReviews();
    } catch (e) {
      return showError(e.toString());
    }
  }
}
