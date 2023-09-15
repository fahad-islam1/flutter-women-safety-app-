import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/res/colors/colors.dart';
import 'package:women_safety_app/res/components/parent/parent_drawer.dart';
import 'package:women_safety_app/res/utils/utils.dart';
import 'package:women_safety_app/view_model/auth/login_view_model.dart';
import 'package:women_safety_app/view_model/chat_view_model.dart';
import 'package:women_safety_app/views/child/chat/chat_Screen.dart';

class ParentHomeScreen extends StatelessWidget {
  const ParentHomeScreen({super.key});

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var chatViewModel = Get.put(ChatViewModel());
    var loginModel = Get.find<LoginViewModel>();

    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  // Open the drawer when the IconButton is pressed
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu),
              );
            },
          ),
          backgroundColor: primaryColor,
          title: const Text(
            'Select Child',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2.0),
          ),
          centerTitle: true,
        ),
        drawer: parentDrawer(size, chatViewModel, loginModel),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: chatViewModel.getChildData(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return loadingIndicator();
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong!'));
                    } else if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text('    No child registered yet!'));
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
                    }
                  }),
            ),
          ],
        ));
  }
}
