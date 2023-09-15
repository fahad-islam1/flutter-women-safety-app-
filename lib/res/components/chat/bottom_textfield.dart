import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:women_safety_app/res/colors/colors.dart';
import 'package:women_safety_app/view_model/bottom_sheat_view_model.dart';
import 'package:women_safety_app/view_model/chat_view_model.dart';

class BottomTextField extends StatelessWidget {
  final String friendId;

  BottomTextField({
    Key? key,
    required this.friendId,
  }) : super(key: key);

  final chatViewModel = Get.find<ChatViewModel>();
  final bottomSheatController = Get.put(BottomSheetControllers());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              showBottomSheetIcons();
            },
            icon: Icon(
              Icons.add_box,
              size: 26,
              color: white,
            ),
          ),
          Expanded(
            child: TextField(
                controller: chatViewModel.controller,
                decoration: const InputDecoration(
                  hintText: 'Type a message',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 18, color: Colors.white)),
          ),
          IconButton(
            onPressed: () {
              if (chatViewModel.controller.text.isNotEmpty) {
                chatViewModel.sendMessage(
                    friendId: friendId,
                    type: 'text',
                    message: chatViewModel.controller.text);
              }
              chatViewModel.controller.text = '';
            },
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  showBottomSheetIcons() {
    Get.bottomSheet(Container(
      height: 140,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          bottomIcons(
              title: 'Camera',
              icon: Icons.camera_alt,
              onTap: () async {
                await chatViewModel.selectImage(ImageSource.camera);
                await chatViewModel.uploadImage();
                await chatViewModel.sendMessage(
                    friendId: friendId,
                    type: 'Image',
                    message: chatViewModel.imageUrls.value);
                Get.back();
              }),
          bottomIcons(
              title: 'Gallery',
              icon: Icons.image,
              onTap: () async {
                await chatViewModel.selectImage(ImageSource.gallery);
                await chatViewModel.uploadImage();
                chatViewModel.sendMessage(
                    friendId: friendId,
                    type: 'Image',
                    message: chatViewModel.imageUrls.value);
                Get.back();
              }),
          bottomIcons(
              title: 'Mic',
              icon: Icons.mic,
              onTap: () {
                chatViewModel.audioService.requestAudioPermission();
              }),
          bottomIcons(
              title: 'Location',
              icon: Icons.location_on,
              onTap: () {
                bottomSheatController.getCurrentLocation();
                String msgbody =
                    "https://maps.google.com/?daddr=${bottomSheatController.currentPosition!.latitude},${bottomSheatController.currentPosition!.longitude}";
                Future.delayed(const Duration(seconds: 2), () {
                  chatViewModel.sendMessage(
                      friendId: friendId, type: 'Link', message: msgbody);
                });
                Get.back();
              }),
        ],
      ),
    ));
  }

  bottomIcons({String? title, icon, onTap}) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: primaryColor,
            child: IconButton(
              onPressed: onTap,
              icon: Icon(
                icon,
                size: 26,
                color: white,
              ),
            ),
          ),
          Text(
            title!,
            style: const TextStyle(
                // fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }
}
