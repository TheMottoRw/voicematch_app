import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voicematch/api/ApiMessages.dart';
import 'package:voicematch/models/message_model.dart';
import 'package:voicematch/models/user_model.dart';
import 'package:voicematch/screens/Chat.dart';

void main() => runApp(MyRecentChat());

class MyRecentChat extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State {
  // final String title;
  var data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Message>>(
        future: ApiMessages.loadRecentChats(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
            print("Snap data "+snapshot.data.toString());
            return ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
              children: snapshot.data.map((e) =>  MyRecentChatCard(image: 'asua.png',chat_with: e.chat_with,text: e.caption,date: e.time)).toList()
            );
          },
      ),
    );
  }
}

class MyRecentChatCard extends StatelessWidget {
  MyRecentChatCard({Key key, this.image, this.chat_with, this.text, this.date})
      : super(key: key);
  final User chat_with;
  final String image, text, date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 120,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/' + this.image),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    GestureDetector(
                      child: Text(this.chat_with.name,style: TextStyle(fontWeight: FontWeight.bold),),
                      onTap: () {
//                        _showDialog(context,'tapped',this.name,this.address);
                        var receiverObj = '{"receiver":${this.chat_with.id},"receiverName":"${this.chat_with.name}"}';
                        Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => ChatUI(),
                              settings: RouteSettings(arguments: receiverObj),
                            ));
                      },
                    ),
                    Text(this.text,style: TextStyle(fontSize: 13),),
                    Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.all(2),
                    child:Text(this.date.substring(5,22),style: TextStyle(fontSize: 10,color: Color.fromRGBO(120, 125, 125, 1)),),
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

  void _showDialog(BuildContext context, event, name, address) {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text('User details ' + event),
            content: new Text(name + "\n" + " live in " + address),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  }, child: new Text("Close"))
            ],
          );
        }
    );
  }

  static Future<String> _getSession() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String userId = await sh.getString("sessid") ?? "";
    return userId;
  }
}