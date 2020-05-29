import 'package:flutter/material.dart';
import 'package:voicematch/screens/Login.dart';

void main() {
  runApp(MaterialApp(
    home: MyLoginApp(),
    theme: ThemeData(
      primarySwatch: Colors.blueGrey,
    ),
    title: 'Voice match',
  ));
}
class MyLoginApp extends StatefulWidget{
  @override
  _State createState() => _State();
}

class _State extends State{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice match'),
      ),
      body: LoginUI(),
    );
  }
}
