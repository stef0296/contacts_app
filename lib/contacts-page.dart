import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/contact-provider.dart';
import 'contact-card.dart';
import 'dummy-data.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {

  void _getContacts() {
    ContactProvider contactProvider = Provider.of<ContactProvider>(context, listen: false);
    contactProvider.contacts = dummyData;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      backgroundColor: Color(0xFFFAFAFA),
      body: _buildListView(),
    );
  }

  Widget _buildListView() {
    return Consumer<ContactProvider>(
      builder: (__, model, _) {
        return ListView.builder(
          itemBuilder: (_, index) {
            return ContactCard(model.contacts[index]);
          },
          itemCount: model.contacts.length,
        );
      },
    );
  }
}
