import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/data/hive%20db/boxes.dart';
import 'package:women_safety_app/model/contact_model.dart';
import 'package:women_safety_app/res/utils/utils.dart';

class HiveDb{
  
  Future<void> saveContactToHive(Contact contact) async {
    final newContact = ContactModel(
      name: contact.displayName!,
      phoneNumber:
          contact.phones!.isNotEmpty ? contact.phones!.first.value! : "",
    );

    final box = Boxes.getContacts();

    //  Check if the contact already exists in the list
    final existingIndex = box.values.toList().indexWhere((storedContact) =>
        storedContact.name == newContact.name &&
        storedContact.phoneNumber == newContact.phoneNumber);

    if (existingIndex != -1) {
      // Contact already exists, show a popup or snackbar to inform the user
      showError(
        "Contact Already Exists",
      );
      return;
    }

    Get.back();
    await box.add(newContact);
    showSuccess(contact.displayName!, "Contact Added Successfully");
  }
}