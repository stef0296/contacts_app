import 'package:flutter/material.dart';
import 'contact-card.dart';

import 'dummy-data.dart';
import 'model/contact.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  Future<List<Contact>> _contacts;

  Future<List<Contact>> _getContacts() async {
    List<Contact> contacts = dummyData;
    await Future.delayed(Duration(seconds: 10));
    return Future.value(contacts);
  }

  @override
  void initState() {
    super.initState();
    _contacts = _getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Contact>>(
      future: _contacts,
      builder: (ctx, snapshot) {
        List<Contact> contacts = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return _buildListView(contacts);
          default:
            return _buildLoadingScreen();
        }
      },
    );
  }

  Widget _buildListView(List<Contact> contacts) {
    return ListView.builder(
      itemBuilder: (ctx, idx) {
        return ContactCard(contacts[idx]);
      },
      itemCount: contacts.length,
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
