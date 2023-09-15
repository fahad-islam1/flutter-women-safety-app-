import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_app/res/const/firebase_const.dart';
import 'package:women_safety_app/res/utils/utils.dart';

class AccountServices {
  updateName({name}) {
    return firestore.collection(usercollection).doc(auth.currentUser!.uid).set({
      'name': name,
    }, SetOptions(merge: true));
  }

  Future<void> updateImageUrl({required String imageUrl}) async {
    firestore.collection(usercollection).doc(auth.currentUser!.uid).set({
      'imageUrl': imageUrl,
    }, SetOptions(merge: true));
  }

  getImage() async {
    return await firestore
        .collection(usercollection)
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      var imageUrl = value.data()!['imageUrl'];
      return imageUrl;
    }).catchError((e) {
      return showError(e.toString());
    });
  }


  
}


    // 'id': auth.currentUser!.uid,
      // 'phone': '0301679938',
      // 'email': "ali@gmail.com",
      // 'gmail': 'parent1@gmail.com'