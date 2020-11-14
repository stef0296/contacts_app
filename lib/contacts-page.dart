import 'package:contacts_app/contact-form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/contact.dart';
import 'provider/contact-provider.dart';
import 'contact-card.dart';
import 'dummy-data.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  void _getContacts() async {
    await Future.delayed(Duration(milliseconds: 200));
    ContactProvider contactProvider =
        Provider.of<ContactProvider>(context, listen: false);
    contactProvider.contacts = dummyData;
  }

  void _updateContact(int index, Contact contact) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactForm(
          index: index,
          contact: contact,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getContacts();
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      backgroundColor: Color(0xFFFAFAFA),
      body: _buildListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContactForm(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildListView() {
    return Consumer<ContactProvider>(
      builder: (__, model, _) {
        return ListView.builder(
          itemBuilder: (_, index) => ContactCard(
            index: index,
            contact: model.contacts[index],
            updateCallback: _updateContact,
            deleteCallback: () => model.removeContact(index),
          ),
          itemCount: model.contacts.length,
        );
      },
    );
  }
}
