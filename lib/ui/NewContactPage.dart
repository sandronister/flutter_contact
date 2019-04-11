import 'dart:io';

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
  bool _userEdited=false;

  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _phoneController;

  @override
  void initState() {
    if (widget.contact == null) {
      _editContact = Contact();
    } else {
      _editContact = Contact.fromMap(widget.contact.toMap());
      _nameController.text   =  _editContact.name;
      _emailController.text  =  _editContact.email;
      _phoneController.text  =  _editContact.phone;
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
        onPressed: () {},
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child:Container(
                width: 140.0,
                height: 140.0 ,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _editContact.img != null ?
                        FileImage(File(_editContact.img)):
                        AssetImage('image/person.jpg')
                    )
                ),
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Nome:"),
              onChanged: (text){
                _userEdited = true;

                setState(() {
                  _editContact.name = text;
                });
              },
              keyboardType: TextInputType.text
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "E-mail:"),
              onChanged: (text){
                _userEdited = true;
                 _editContact.email= text;

              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone:"),
              onChanged: (text){
                _userEdited = true;
                _editContact.phone= text;

              },
              keyboardType: TextInputType.phone,
            )
          ],
        ),
      ),
    );
  }
}
