import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/res/colors/colors.dart';
import 'package:women_safety_app/view_model/contacts_view_model.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactViewModel viewModel = Get.put(ContactViewModel());

    // print('contactfilterList length: ${viewModel.contactfilterList.length}');
    // print('contactList length: ${viewModel.contactList.length}');

    return Scaffold(
      body: Obx(() {
        bool isSearching = viewModel.searchController.text.isNotEmpty;
        bool hasContacts = (viewModel.contactfilterList.isNotEmpty ||
            viewModel.contactList.isNotEmpty);

        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  autofocus: true,
                  controller: viewModel.searchController,
                  decoration: const InputDecoration(
                    labelText: "Search contact",
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              hasContacts
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: isSearching
                            ? viewModel.contactfilterList.length
                            : viewModel.contactList.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          log('Index: $index, Contact List Size: ${viewModel.contactList.length}');
                          if (index < viewModel.contactList.length) {
                            var contact = isSearching
                                ? viewModel.contactfilterList[index]
                                : viewModel.contactList[index];
                            return ListTile(
                              title: Text(contact.displayName!),
                              subtitle:
                                  Text(contact.phones!.elementAt(0).value!),
                              leading: contact.avatar != null &&
                                      contact.avatar!.isNotEmpty
                                  ? CircleAvatar(
                                      backgroundColor: primaryColor,
                                      backgroundImage:
                                          MemoryImage(contact.avatar!),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: primaryColor,
                                      child: Text(contact.initials()),
                                    ),
                              onTap: () {
                                viewModel.saveContactToHive(contact);
                              },
                            );
                          } else if (viewModel.contactList.length >=
                              viewModel.contactsPerPage) {
                            // Load more contacts when reaching the end of the list
                            viewModel.getAllContacts();

                            return CircularProgressIndicator(); // Or another loading indicator
                          } else {
                            // No more contacts to load
                            return Text("No more contacts to load");
                          }
                        },
                      ),
                    )
                  : const Text("Searching"),
            ],
          ),
        );
      }),
    );
  }
}
