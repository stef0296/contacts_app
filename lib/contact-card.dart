import 'package:flutter/material.dart';
import 'model/contact.dart';

class ContactCard extends StatelessWidget {
  final int index;
  final Contact contact;
  final Function updateCallback;
  final Function deleteCallback;

  ContactCard({
    this.index,
    this.contact,
    this.updateCallback,
    this.deleteCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[500],
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, right: 15, bottom: 10),
            child: ClipOval(
              child: Image.network(
                contact.imageUrl,
                width: 50,
                height: 50,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${contact.firstName} ${contact.lastName}'),
                SizedBox(height: 2),
                Text('${contact.phone}'),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: deleteCallback,
                child: Icon(
                  Icons.delete,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(width: 15.0),
              GestureDetector(
                onTap: () => updateCallback(index, contact),
                child: Icon(
                  Icons.create,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(width: 15.0),
              Icon(
                Icons.message,
                color: Colors.grey[600],
              ),
              SizedBox(width: 15.0),
              Icon(
                Icons.call,
                color: Colors.grey[600],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
