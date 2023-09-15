import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:women_safety_app/data/services/chat_audio_services.dart';
import 'package:women_safety_app/data/services/chat_firestore_Services.dart';
import 'package:women_safety_app/data/services/chat_image_services.dart';
import 'package:women_safety_app/data/services/chat_message_services.dart';
import 'package:women_safety_app/res/const/firebase_const.dart';
import 'package:women_safety_app/res/utils/utils.dart';
// import 'package:intl/intl.dart';

class ChatViewModel extends GetxController {
  final Rx<Timestamp?> date = Rx<Timestamp?>(null);
  var status = ''.obs;
  var name = ''.obs;
  var controller = TextEditingController();
  var imagePath = ''.obs;
  var imageUrls = ''.obs;

  final ChatFirestoreService firestoreService = ChatFirestoreService();
  final ChatMessageService messageService = ChatMessageService();
  final ChatImageService imageService = ChatImageService();
  final ChatAudioService audioService = ChatAudioService();

  @override
  onInit() {
    getstatus();

    super.onInit();
  }

  getstatus() async {
    return await firestore
        .collection(usercollection)
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      status.value = value.data()!['type'];
      name.value = value.data()!['name'];
    }).catchError((e) {
      return showError(e.toString());
    });
  }

  Stream<QuerySnapshot> getChat(friendid) {
    return firestoreService.getChat(friendid);
  }

  Stream<QuerySnapshot> getChildData() {
    return firestoreService.getChildData();
  }

  sendMessage({friendId, message, type}) {
    return messageService.sendMessage(
        friendId: friendId, message: message, type: type);
  }

  deleteMsg({friendid, docId}) {
    return messageService.deleteMessage(friendId: friendid, docId: docId);
  }

  Stream<QuerySnapshot> getParentData() {
    return firestoreService.getParentData();
  }

  selectImage(ImageSource source) async {
    try {
      final path = await imageService.selectImage(source: source);
      if (path != null) {
        imagePath.value = path;
      } else {
        showError("No image selected.");
      }
    } catch (e) {
      showError("Error selecting image: $e");
    }
  }

  Future<void> uploadImage() async {
    try {
      var value = await imageService.uploadImage(imagePath: imagePath.value);
      if (value != null) {
        imageUrls.value = value;
      }
      print("value :${imageUrls.value} ");
    } catch (e) {
      showError("Error uploading image: $e");
    }
  }
}
