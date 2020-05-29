import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Menu.dart';

void main(){
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

class MyConfirmApp extends StatefulWidget{
  @override
  _State createState() => _State();
}

class _State extends State{

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
class ConfirmUI extends StatelessWidget{

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              controller: nameController,
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
              onPressed: (){
                print("Code sent "+nameController.text);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyTabApp()));
              },
            ),
          ),
        ],
      ),
    );
  }
}