import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voicematch/screens/Login.dart';
import 'package:voicematch/screens/Menu.dart';

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

class _State extends State {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSession().then((value) {
      if (value != "") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyTabApp()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice match'),
      ),
      body: LoginUI(),
    );
  }

  static Future<String> _getSession() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String userId = await sh.getString("sessid") ?? "";
    return userId;
  }
}