import 'package:contacts_app/model/contact.dart';
import 'package:contacts_app/provider/contact-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactForm extends StatefulWidget {
  static const route = '/contact_form';
  final int index;
  final Contact contact;

  ContactForm({this.index, this.contact});

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  String imageUrl = 'https://picsum.photos/100';
  TextEditingController _fNameController = TextEditingController();
  TextEditingController _lNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  void addContact() {
    Contact contact = Contact(
      firstName: _fNameController.text,
      lastName: _lNameController.text,
      phone: _phoneController.text,
      imageUrl: imageUrl
    );

    ContactProvider contactProvider = Provider.of<ContactProvider>(context, listen: false);
    contactProvider.addContact(contact);
    Navigator.of(context).pop();
  }

  void updateContact() {
    Contact contact = Contact(
        firstName: _fNameController.text,
        lastName: _lNameController.text,
        phone: _phoneController.text,
        imageUrl: imageUrl
    );
    ContactProvider contactProvider = Provider.of<ContactProvider>(context, listen: false);
    contactProvider.updateContact(widget.index, contact);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    if(widget.contact != null) {
      _fNameController.text = widget.contact.firstName;
      _lNameController.text = widget.contact.lastName;
      _phoneController.text = widget.contact.phone;
      imageUrl = widget.contact.imageUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Form'),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              if(widget.contact == null)
                addContact();
              else
                updateContact();
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 8.0),
              child: Text('Submit'),
            ),
          ),
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.network(
                  imageUrl,
                  width: 80,
                  height: 80,
                ),
              ),
              TextFormField(
                controller: _fNameController,
                decoration: InputDecoration(
                  labelText: 'First Name'
                ),
              ),
              TextFormField(
                controller: _lNameController,
                decoration: InputDecoration(
                    labelText: 'Last Name'
                ),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                    labelText: 'Phone Number'
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
