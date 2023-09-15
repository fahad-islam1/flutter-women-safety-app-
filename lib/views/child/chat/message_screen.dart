import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_safety_app/res/colors/colors.dart';
import 'package:women_safety_app/res/utils/utils.dart';
import 'package:women_safety_app/view_model/chat_view_model.dart';

class MessageScreen extends StatelessWidget {
  final String? message;
  final bool? isMe;
  final String? image;
  final String? type;
  final String? friendName;
  final String? myName;
  final date;

  MessageScreen({
    Key? key,
    this.message,
    this.isMe,
    this.image,
    this.type,
    this.friendName,
    this.myName,
    this.date,
  }) : super(key: key);

  final chatViewModel = Get.find<ChatViewModel>();
  String formattedDate = '';

  @override
  Widget build(BuildContext context) {
    if (date != null) {
      DateTime dateTime = date!.toDate();
      formattedDate = DateFormat('HH:mm').format(dateTime);
    }

    return Column(
      children: [
        Align(
          alignment: isMe! ? Alignment.bottomRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 2,
            ),
            padding: EdgeInsets.all(type == 'Image' ? 0 : 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isMe! ? 15 : 0),
                topRight: Radius.circular(isMe! ? 0 : 15),
                bottomLeft: const Radius.circular(15),
                bottomRight: const Radius.circular(15),
              ),
              color: type == 'Image' ? Colors.transparent : primaryColor,
            ),
            child: getMessageWidget(),
          ),
        ),
      ],
    );
  }

  Widget getMessageWidget() {
    if (type == 'text') {
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          crossAxisAlignment:
              isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment:
              isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Text(
              message!,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: isMe! ? Alignment.centerRight : Alignment.centerLeft,
              child: Text(
                formattedDate,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    } else if (type == 'Image') {
      return Column(
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisAlignment:
            isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isMe! ? 15 : 0),
                topRight: Radius.circular(isMe! ? 0 : 15),
                bottomLeft: const Radius.circular(15),
                bottomRight: const Radius.circular(15),
              ),
              color: Colors.transparent,
            ),
            child: CachedNetworkImage(
              imageUrl: message!.isEmpty
                  ? 'https://www.esm.rochester.edu/uploads/NoPhotoAvailable.jpg'
                  : message!,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (_, __, ___) => Center(
                child: loadingIndicator(),
              ),
              errorWidget: (_, __, ___) => const Icon(Icons.error),
            ),
          ),
          Align(
            alignment: isMe! ? Alignment.centerRight : Alignment.centerLeft,
            child: Text(
              formattedDate,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    } else if (type == 'voice') {
      return GestureDetector(
        onTap: () {
          // Implement logic to play the voice message
          // Show playback UI (e.g., a play button)
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200], // Customize the message bubble color
          ),
          child: const Row(
            children: [
              Icon(
                Icons.play_arrow,
                color: Colors.blue, // Customize the play button color
              ),
              SizedBox(width: 8),
              Text(
                "Voice message",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () async {
          await launchUrl(Uri.parse(message!));
        },
        child: Column(
          crossAxisAlignment:
              isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment:
              isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    message!,
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
                Icon(Icons.location_on, color: white, size: 40),
              ],
            ),
            Align(
              alignment: isMe! ? Alignment.centerRight : Alignment.centerLeft,
              child: Text(
                formattedDate,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }
  }
}
