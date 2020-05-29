import 'package:flutter/material.dart';
import 'package:voicematch/screens/Confirm.dart';

//void main(){
//  runApp(
//    MaterialApp(
//      home: MyLoginApp(),
//    )
//  );
//}

class LoginUI extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Image.asset('assets/logo.png',
            height: 120,),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Text(
              'Signin to continue',
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: 22),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: phoneController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone number',
              ),
            ),
          ),
          FlatButton(
            onPressed: () {},
            textColor: Colors.blueGrey,
            child: Text('Forgot password'),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.blueGrey,
              child: Text('Sign in'),
              onPressed: () {
                print("Username is " + nameController.text);
                print("Password is " + phoneController.text);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyConfirmApp()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
