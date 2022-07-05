import 'package:document_bank/core/utils/exceptions.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

abstract class LocalSource {
  Future<List<Contact>> fetchMobileContacts();
}

class LocalSourceImpl implements LocalSource {
  @override
  Future<List<Contact>> fetchMobileContacts() async {
    try {
      if (await FlutterContacts.requestPermission()) {
        return await FlutterContacts.getContacts(
          withProperties: true,
          withPhoto: true,
        );
      } else {
        throw LocalException(message: "No contact permission granted");
      }
    } on Exception catch (e) {
      throw LocalException(message: e.toString());
    }
  }
}
