import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:shared/shared.dart';

class Contact {
  Contact({
    @required this.name,
  });

  final String name;
}

class ContactService {
  ContactService(Config config);

  Future<List<Contact>> loadContacts() async {
    await Future.delayed(Duration(seconds: 1));
    return List.generate(
        40,
        (index) => Contact(
              name: 'Contact $index',
            ));
  }
}

class InternalContactModel extends ChangeNotifier {
  InternalContactModel(this.service);

  final ContactService service;
  AsyncSnapshot<List<Contact>> contacts = AsyncSnapshot.nothing();

  Future<void> loadContacts() async {
    if (contacts.hasData) {
      return;
    }

    contacts = contacts.inState(ConnectionState.waiting);
    notifyListeners();
    try {
      contacts = AsyncSnapshot.withData(
          ConnectionState.done, await service.loadContacts());
    } catch (e) {
      contacts = AsyncSnapshot.withError(ConnectionState.done, e);
    } finally {
      notifyListeners();
    }
  }
}
