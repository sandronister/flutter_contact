import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_contact/helpers/ContactHelpers.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  ContactHelper helper = ContactHelper();
  List<Contact> contacts = List();


  @override
  void initState() {
    super.initState();

    helper.getAllContacts().then((list){
      setState(() {
        contacts = list;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Contato'),
          centerTitle: true,
          backgroundColor: Colors.red),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
          itemCount: contacts.length,
          itemBuilder: (context,index){
           return  _contactCard(context, index);
          }),
    );
  }

  Widget _contactCard(BuildContext context,int index){
    return GestureDetector(
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 80.0,
                  height: 80.0 ,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: contacts[index].img != null ?
                            FileImage(File(contacts[index].img)):
                            AssetImage('image/person.jpeg')
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(contacts[index].name ?? "",style: TextStyle(fontSize: 22.0,fontWeight:FontWeight.bold)),
                      Text(contacts[index].email ?? "",style: TextStyle(fontSize: 18.0)),
                      Text(contacts[index].phone ?? ",",style: TextStyle(fontSize: 16.0))
                    ],
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}
