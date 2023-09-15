import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/res/colors/colors.dart';
import 'package:women_safety_app/res/utils/utils.dart';
import 'package:women_safety_app/view_model/chat_view_model.dart';
import 'package:women_safety_app/views/child/chat/chat_Screen.dart';

class ParentListScreen extends StatelessWidget {
  const ParentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    var chatViewModel = Get.put(ChatViewModel());

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text(
            'Select Guardian',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2.0),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: chatViewModel.getParentData(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return loadingIndicator();
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong!'));
                    } else {
                      var data = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ListTile(
                                onTap: () {
                                  Get.to(() => ChatScreen(
                                        data: data[index],
                                      ));
                                },
                                // leading: CircleAvatar(
                                //   radius: 30,
                                //   backgroundColor: Colors.transparent,
                                //   child: CachedNetworkImage(
                                //       imageUrl: data[index]['imageUrl'],
                                //       fit: BoxFit.fill,
                                //       errorWidget: (context, url, error) {
                                //         return const Icon(Icons.error);
                                //       }),
                                // ),
                                title: Text(
                                  data[index]['name'],
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  data[index]['childemail'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                      // return Text('No Parent registered yet!');
                    }
                  }),
            ),
          ],
        ));
  }
}
