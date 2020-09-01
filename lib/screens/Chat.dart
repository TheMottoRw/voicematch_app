import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voicematch/api/ApiMessages.dart';
import 'package:voicematch/models/message_model.dart';
import 'package:voicematch/widgets/recent_chats.dart';

void main() => runApp(ChatApp());

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.grey,
      ),
      home: ChatUI(),
    );
  }
}

class ChatUI extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          'Chat',
        ),
        automaticallyImplyLeading: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.perm_identity),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          )
        ],
      ),
      body: HomeScreenUI()
    );
  }
}

class HomeScreenUI extends StatelessWidget {
  int receiver = 0;
  String receiverName = "";
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userData = jsonDecode(ModalRoute
        .of(context)
        .settings
        .arguments);
    print("data "+userData['receiverName']);
        receiver = userData['receiver'];
        receiverName = userData['receiverName'];
        print("Receiver $receiver - $receiverName");
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 500.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0))),
            child: Column(
              children: <Widget>[
                FutureBuilder<List<Message>>(
                  future: _getSession().then((value) => ApiMessages.loadChats(value,receiver.toString())),
                  builder: (context, snapshot){
                    // print("Kept loading msg "+snapshot.data.toString());
                    if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
                    print("Message found "+snapshot.data.toString());

                    // Message.chats = snapshot.data;
                    return ChatRow(chats: snapshot.data);
                    /*return ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
                      children: snapshot.data.map((msg){
                        ChatRow(image:'assets/logo.png',name:msg.chat_with.name,caption:msg.caption,time:msg.time,unread:false);
                      }).toList(),
                    );
                    */
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Colors.blueGrey),
                      child: Icon(
                        Icons.mic,
                        color: Colors.white,
                      ),
                      height: 40,
                      width: 40,
                    ),
                    Container(
                      width: 300,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(10.0)),
                      ),
                      child: TextField(
                        controller: messageController,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        expands: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            fillColor: Colors.blueGrey),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.blueGrey,
                      ),
                      child: GestureDetector(
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        onTap: () {
                          sendMessage(messageController.text);
                          messageController.clear();
                          },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void sendMessage(String message) {
    //call message sender api
    var sender = _getSession(),receiver = this.receiver.toString(),voices = "";
    const platform = const MethodChannel("toast.flutter.io/toast");
    sender.then((sender){
        var resp = ApiMessages.create(sender, voices, message, receiver);
        print("Message to be sent " + message+" Sender $sender Receiver $receiver");
        resp.then((value){
          if(value=='ok') platform.invokeMethod("showToast", {"message": "Message sent succeful"});
          else platform.invokeMethod("showToast", {"message": "Message not sent,something went wrong"});
        });
    });

  }
  static Future<String> _getSession() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String userId = await sh.getString("sessid") ?? "";
    return userId;
  }
  static String _getSessionData(){
    String val = "";
    _getSession().then((value) {
      val = value;
    });
    print("sessid $val");
    return val;
  }

}
