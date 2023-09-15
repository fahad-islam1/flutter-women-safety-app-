import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_app/res/const/firebase_const.dart';

class ChatFirestoreService {
  // get child chat data
  Stream<QuerySnapshot> getParentData() {
    return firestore
        .collection(usercollection)
        .where('type', isEqualTo: 'parent')
        .where('childemail', isEqualTo: auth.currentUser!.email)
        .snapshots();
  }

  // get parent  data
  Stream<QuerySnapshot> getChildData() {
    return firestore
        .collection(usercollection)
        .where('type', isEqualTo: 'child')
        .where('parentemail', isEqualTo: auth.currentUser!.email)
        .snapshots();
  }

  // get chat

  getChat(friendid) {
    return firestore
        .collection(chatcollection)
        .doc(auth.currentUser!.uid)
        .collection(allmsgcollection)
        .doc(friendid)
        .collection(msgcollection)
        .orderBy('time', descending: false)
        .snapshots();
  }


}
