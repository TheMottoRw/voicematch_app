import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:voicematch/api/ApiContacts.dart';
import 'package:voicematch/models/user_model.dart';

import 'Chat.dart';

void main() => runApp(MyContactInfo());

class Contacts extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voice match',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.grey
      ),
      home: MyContactInfo(),
    );
  }
}
class MyContactInfo extends StatelessWidget{
  final String title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: ApiContacts.loadContacts(),
        builder: (context, snapshot){
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
         return ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(2.0,10.0,2.0,10.0),
              children: snapshot.data.map((e) => MyContactCard(id: e.id,image: e.imageUrl,name: e.name,phone: e.contact,address: 'dx')).toList(),
          );
        },
      )
    );
  }
}
class MyContactCard extends StatelessWidget{
  MyContactCard({Key key,this.id,this.image,this.name,this.phone,this.address}) : super(key:key);
  final String image,name,phone,address;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 120,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage(this.image),
              radius: (40),
              ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: <Widget>[
                    GestureDetector(
                      child: Text(this.name,style: TextStyle(fontWeight: FontWeight.bold),),
                      onTap: (){
//                        _showDialog(context,'tapped',this.name,this.address);
                      var receiverObj = '{"receiver":${this.id},"receiverName":"${this.name}"}';
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => ChatUI(),
                                settings: RouteSettings(arguments: receiverObj)
                            ));
                      },
                    ),

                    Text(this.phone),
                    // Text("Location:"+this.address),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void _showDialog(BuildContext context,event,name,address){
    showDialog(
      context: context,
      builder: (BuildContext){
        return AlertDialog(
          title: Text('User details '+event),
          content: new Text(name+"\n"+" live in "+address),
          actions: <Widget>[
            new FlatButton(
                onPressed: (){
              Navigator.of(context).pop();
            }, child: new Text("Close"))
          ],
        );
      }
    );
  }
}
class UserObj{
  int receiver;
  String receiverName;
  UserObj({this.receiver,this.receiverName});
}