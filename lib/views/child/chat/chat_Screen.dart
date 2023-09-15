// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/res/colors/colors.dart';
import 'package:women_safety_app/res/components/chat/bottom_textfield.dart';
import 'package:women_safety_app/res/const/firebase_const.dart';
import 'package:women_safety_app/res/utils/utils.dart';
import 'package:women_safety_app/view_model/chat_view_model.dart';
import 'package:women_safety_app/views/child/chat/message_screen.dart';

class ChatScreen extends StatelessWidget {
  dynamic data;
  ChatScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    var chatViewModel = Get.find<ChatViewModel>();
    String friendId = data['id'];
    // print(chatViewModel.status.value);
    final ScrollController _scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          data['name'],
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2.0),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: chatViewModel.getChat(data['id']),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return loadingIndicator();
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong!'));
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(
                        child: chatViewModel.status.value == 'child'
                            ? const Text(
                                'Talk with Parent',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const Text(
                                'Talk with Child',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ));
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    });
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var snapshotdata = snapshot.data!.docs[index];

                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) {
                          chatViewModel.deleteMsg(
                                  friendid: friendId, docId: snapshotdata.id);
                            },
                            child: MessageScreen(
                              message: snapshotdata['message'],
                              isMe: snapshotdata['senderid'] ==
                                  auth.currentUser!.uid,
                              image: "",
                              // image: data[index]['image'],
                              type: snapshotdata['type'],
                              // friendName: data[index]['name'],
                              friendName: '',
                              myName: chatViewModel.name.value,
                              date: snapshotdata['time'],
                            ),
                          ),
                        );
                      },
                    );
                    // return Text('No Parent registered yet!');
                  }
                }),
          ),
          BottomTextField(
            friendId: friendId,
          )
        ],
      ),
    );
  }
}
