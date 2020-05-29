import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voicematch/screens/Contacts.dart';
import 'package:voicematch/screens/RecentChat.dart';

void main() => runApp(MyTabApp());

class MyTabApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voice match',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.grey,
      ),
      home: MyTabHome(),
    );
  }
}
class MyTabHome extends StatefulWidget{
  @override
  _MyTabHomeState createState() => _MyTabHomeState();
}
class _MyTabHomeState extends State{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Voice match'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.chat ),
                text: 'Chat'),
              Tab(
                icon: Icon(Icons.contacts),
                text: 'Contact',
              )
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {},
            )
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            Center(child: MyRecentChatInfo()),
            Center(child: MyContactInfo()),
          ],
        ),
      ),
    );
  }
}