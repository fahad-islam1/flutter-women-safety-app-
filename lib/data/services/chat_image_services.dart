import 'package:image_picker/image_picker.dart';
import 'package:women_safety_app/res/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ChatImageService {
  Future<String?> selectImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();
    try {
      final image = await picker.pickImage(source: source, imageQuality: 70);
      if (image == null) return null;
      return image.path;
    } catch (e) {
      showError(e.toString());
      return null;
    }
  }

  Future<String?> uploadImage({required String imagePath}) async {
    try {
      var filename = imagePath.split('/').last;
      var destination = 'profileImages/$filename';
      Reference ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(File(imagePath));
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      showError(e.toString());
      return null;
    }
  }
}
