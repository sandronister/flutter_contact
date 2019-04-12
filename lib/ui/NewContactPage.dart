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

  final _nameController  = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _namedFocus = FocusNode();

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
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_editContact.name ?? "Novo Contato"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if(_editContact.name != null && _editContact.name.isNotEmpty){
              Navigator.pop(context,_editContact);
            }else{
              FocusScope.of(context).requestFocus(_namedFocus);
            }
          },
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
                  focusNode: _namedFocus,
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
      )
    );
  }

  Future<bool> _requestPop(){

    if(_userEdited){
      showDialog(context: context,
                  builder:(context){
                    return AlertDialog(
                        title:Text("Descartar Alterações"),
                        content: Text("Se sair as alterações serão perdidas"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Cancelar"),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text("Confirmar"),
                            onPressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          )
                        ],
                    );
                  }
      );

      return Future.value(false);
    }else{
      return Future.value(true);
    }
  }
}
