import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:women_safety_app/data/hive%20db/hive_db.dart';
import 'package:women_safety_app/res/utils/utils.dart';

class ContactViewModel extends GetxController {
  List<Contact> contactList = <Contact>[].obs;
  final contactsPerPage = 20;
  int currentPage = 0;

  var searchController = TextEditingController();
  List<Contact> contactfilterList = <Contact>[].obs;

  HiveDb hivedb = HiveDb();
  @override
  void onInit() {
    super.onInit();
    askPermission();
    getAllContacts();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

// askPermission to the user
  askPermission() async {
    PermissionStatus permissionStatus =
        await getContactPermission(); // Await here

    if (permissionStatus.isGranted) {
      getAllContacts();
      searchController.addListener(() {
        searchContacts();
      });
    } else {
      handleInvalidPermissions(permissionStatus);
    }
  }

// get Contact Permission
  Future<PermissionStatus> getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;

    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

// handle Invalid Permissions
  handleInvalidPermissions(PermissionStatus permission) {
    if (permission == PermissionStatus.denied) {
      showAlertDialog("Permission Denied", "You have denied the permissions");
    } else if (permission == PermissionStatus.permanentlyDenied) {
      showAlertDialog("Permission Denied", "You have denied the permissions");
    }
  }

  // get all contacts

  // Future<void> getAllContacts() async {
  //   List<Contact> contact = await ContactsService.getContacts();
  //   contactList.assignAll(contact); // Use assignAll() here
  // }
  Future<void> getAllContacts() async {
    final startIndex = currentPage * contactsPerPage;
    final endIndex = startIndex + contactsPerPage;
    final contacts = await ContactsService.getContacts();

    // Ensure startIndex is within bounds
    if (startIndex < contacts.length) {
      final contactsForPage = contacts.sublist(startIndex, endIndex);
      contactList.addAll(contactsForPage);
      currentPage++; // Move to the next page
    }
  }

// search contact
  searchContacts() {
    List<Contact> contacts = [];
    contacts.addAll(contactList);

    if (searchController.text.isNotEmpty) {
      String searchItem = searchController.text.toLowerCase();
      String flattenPhone = flattenPhoneNumber(searchItem);

      contacts.retainWhere((element) {
        String contactName = element.displayName!.toLowerCase();
        bool isNameMatch = contactName.contains(searchItem);

        if (isNameMatch) {
          return true;
        }

        if (flattenPhone.isEmpty) {
          return false;
        }

        // Check for a match in any phone number
        bool isPhoneNumberMatch = element.phones!.any((p) {
          String phoneFlatten = flattenPhoneNumber(p.value!);
          return phoneFlatten.contains(flattenPhone);
        });

        return isPhoneNumberMatch;
      });

      contactfilterList.assignAll(contacts);
    } else {
      contactfilterList.clear();
    }
  }

//  this is used for  when we have + in our contact numbber

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }
// **************************** Hive data base **************************************************
  // hive data base

  Future<void> saveContactToHive(Contact contact) async {
    hivedb.saveContactToHive(contact);
  }
}