import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:voicematch/api/ApiContacts.dart';

import 'Menu.dart';

void main() {
  runApp(
      MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: MyConfirmApp(),
        title: 'Confirm phone',
      )
  );
}

class MyConfirmApp extends StatefulWidget {
  @override
  _State createState() => _State();

}

class _State extends State {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm phone'),
      ),
      body: ConfirmUI(),
    );
  }
}

class ConfirmUI extends StatelessWidget {
  static const platform = const MethodChannel("toast.flutter.io/toast");

  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userData = jsonDecode(ModalRoute
        .of(context)
        .settings
        .arguments),
        userId = userData['userid'],
        verificationCode = userData['code'].toString();
    codeController.text = verificationCode;

    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Text(
              'Confirm phone number',
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: 18
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: codeController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                icon: Icon(Icons.vpn_key),
                border: OutlineInputBorder(),
                labelText: 'Code received',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
            ),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.blueGrey,
              child: Text('Send'),
              onPressed: () {
                var code = codeController.text;
                print("Code sent " + codeController.text);
                var resp = ApiContacts.verify(userId.toString(), code);
                resp.then((value) {
                  if (value == "ok") {
                    _setSession(userId.toString());
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyTabApp()));
                  } else {
                    platform.invokeMethod("showToast", {"message": "Verification failed"});
                    print("verification failed");
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
  void _setSession(String id) async{
    SharedPreferences shpref = await SharedPreferences.getInstance();
    await shpref.setString("sessid", id);
  }
}