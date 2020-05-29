import 'package:flutter/material.dart';

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
      body:  ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(2.0,10.0,2.0,10.0),
              children: <Widget>[
                MyContactCard(image: 'asua.png',name:'Manzi Roger Asua',gender: 'Male',address: 'Sud,Kamonyi'),
                MyContactCard(image: 'kabaka.png',name:'Igihozo Didier Kabaka',gender: 'Male',address: 'Musanze,Nord'),
                MyContactCard(image: 'imenye_logo.png',name: 'Imenye platform',gender: 'Company',address: 'Telecom house'),
            ],
          ),
    );
  }
}
class MyContactCard extends StatelessWidget{
  MyContactCard({Key key,this.image,this.name,this.gender,this.address}) : super(key:key);
  final String image,name,gender,address;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 120,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/'+this.image),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(this.name,
                    style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(this.gender),
                    Text("Location:"+this.address),
                    GestureDetector(
                      child: new Text("More"),
                      onTap: (){
//                        _showDialog(context,'tapped',this.name,this.address);
                        Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => ChatApp(),
                            ));
                      },
                    ),
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