import 'package:hive/hive.dart';
import 'package:women_safety_app/model/contact_model.dart';

class Boxes {
  static Box<ContactModel> getContacts() =>
      Hive.box<ContactModel>('contactsData');
}
