import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_contact/helpers/ContactHelpers.dart';
import 'package:flutter_contact/ui/NewContactPage.dart';
import 'package:url_launcher/url_launcher.dart';

enum Orderoptions {orderaz,orderza}

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

    _getAllContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Contato'),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton<Orderoptions>(
              itemBuilder: (context)=><PopupMenuEntry<Orderoptions>>[
                const PopupMenuItem(
                    child: Text("Ordernar A-Z"),
                    value: Orderoptions.orderaz,
                ),
                const PopupMenuItem(
                  child: Text("Ordernar Z-A"),
                  value: Orderoptions.orderza,
                )
              ],
              onSelected: _orderList,
            )
          ],
          backgroundColor: Colors.red),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactPage();
        },
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
                            AssetImage('image/person.jpg')
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
      onTap: (){
        _showOptions(context,index);
      },
    );
  }

  void _showOptions(BuildContext context,int index){
      showModalBottomSheet(
          context: context,
          builder: (context){
            return BottomSheet(
              onClosing: (){},
              builder: (context){
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                            onPressed: (){
                              launch('tel:${contacts[index].phone}');
                            },
                            child: Text("Ligar",
                              style: TextStyle(color: Colors.red,fontSize: 20.0),
                            )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                            onPressed: (){
                              Navigator.pop(context);
                              _showContactPage(contact: contacts[index]);
                            },
                            child: Text("Editar",
                              style: TextStyle(color: Colors.red,fontSize: 20.0),
                            )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                            onPressed: (){
                              helper.deleteContact(contacts[index].id);
                              setState(() {
                                contacts.removeAt(index);
                                Navigator.pop(context);
                              });
                            },
                            child: Text("Excluir",
                              style: TextStyle(color: Colors.red,fontSize: 20.0),
                            )
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          });
  }

  void _getAllContact(){
    helper.getAllContacts().then((list){
      setState(() {
        contacts = list;
      });
    });
  }

  void _orderList(Orderoptions result){
    switch(result){
      case Orderoptions.orderaz:
          contacts.sort((a,b){
            return a.name.toLowerCase().compareTo(b.name.toLowerCase());
          });
        break;
      case Orderoptions.orderza:
          contacts.sort((a,b){
            return b.name.toLowerCase().compareTo(a.name.toLowerCase());
          });
        break;
    }

    setState(() {

    });
  }

  void _showContactPage({Contact contact}) async {
    final recContact = await Navigator.push(context,
        MaterialPageRoute(builder: (context)=>NewContactPage(contact: contact))
    );

    if(recContact!=null){

      if(contact!=null){
        await helper.updateContact(recContact);
      }else{
        await helper.saveContact(recContact);
      }

      _getAllContact();
    }

  }
}
