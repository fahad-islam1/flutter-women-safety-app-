import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:women_safety_app/data/services/accounts_firestore_services.dart';
import 'package:women_safety_app/data/services/chat_image_services.dart';
import 'package:women_safety_app/res/utils/utils.dart';
import 'package:women_safety_app/view_model/auth/login_view_model.dart';

class AccountsViewModel extends GetxController {
  var imagePath = ''.obs;
  var imageUrls = ''.obs;
  var name = TextEditingController();
  final ChatImageService imageService = ChatImageService();
  final AccountServices accountServices = AccountServices();
  // var logout = 

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    String? url = await accountServices.getImage();
    if (url != null) {
      imageUrls.value = url;
    }
    print(url);
  }

  Future<void> updateName(String name) async {
    try {
      if (name.isNotEmpty) {
        await accountServices.updateName(name: name);
        showSuccess('Name Updated Successfully', '');
      } else {
        showError('Name cannot be empty');
      }
    } catch (e) {
      showError(e.toString());
    }
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

  Future<void> updateImageUrl(String imageUrl) async {
    try {
      if (imageUrl.isNotEmpty) {
        await accountServices.updateImageUrl(imageUrl: imageUrl);
        showSuccess('Image Updated Successfully', '');
      } else {
        showError('Image URL cannot be empty');
      }
    } catch (e) {
      showError(e.toString());
    }
  }

  Future<void> updateProfile() async {
    var nameValue = name.text.trim();
    var newImageUrl = imageUrls.value;

    if (nameValue.isNotEmpty) {
      await updateName(nameValue);
    }

    if (newImageUrl.isNotEmpty) {
      await updateImageUrl(newImageUrl);
    }
  }
}
