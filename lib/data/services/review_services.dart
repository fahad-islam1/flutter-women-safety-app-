import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_app/res/const/firebase_const.dart';

class ReviewServices {
  Future addReviews({String? location, String? review}) async {
    return firestore
        .collection(reviewcollection)
        .add({'location': location, 'review': review});
  }

//  get reviews
  Stream<QuerySnapshot> getReviews() {
    return firestore.collection(reviewcollection).snapshots();
  }
}
