import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:women_safety_app/data/hive%20db/boxes.dart';
import 'package:women_safety_app/model/contact_model.dart';
import 'package:women_safety_app/res/colors/colors.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/views/child/contact/contact_screen.dart';

class AddContacts extends StatelessWidget {
  const AddContacts({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Get.to(() => const ContactScreen());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            child: const Text(
              'Add Trusted Contacts ',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(
                'assets/logo.png',
                height: size.width * 0.5,
                width: size.width * 0.5,
              ),
              Expanded(
                child: ValueListenableBuilder<Box<ContactModel>>(
                  valueListenable: Boxes.getContacts().listenable(),
                  builder: (context, box, child) {
                    if (box.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Trusted contacts available",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: Boxes.getContacts().length,
                        itemBuilder: (context, index) {
                          final contact = box.getAt(index) as ContactModel;
                          return Card(
                            child: ListTile(
                              title: Text(
                                contact.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(contact.phoneNumber),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.call,
                                        color: Colors.green,
                                      ),
                                      onPressed: () async {
                                        await FlutterPhoneDirectCaller
                                            .callNumber(contact.phoneNumber);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        box.deleteAt(index);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        )));
  }
} //
