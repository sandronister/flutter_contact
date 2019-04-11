import 'package:flutter/material.dart';
import 'package:flutter_contact/helpers/ContactHelpers.dart';

class NewContactPage extends StatefulWidget {

  Contact contact;

  NewContactPage({this.contact});

  @override
  _NewContactPageState createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {


  Contact _editContact;

  @override
  void initState() {

    if(widget.contact==null){
      _editContact = Contact();
    }else{
      _editContact = Contact.fromMap(widget.contact.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editContact.name ?? "Novo Contato"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: Icon(Icons.save),
          backgroundColor: Colors.red,
      ),
    );
  }


}
