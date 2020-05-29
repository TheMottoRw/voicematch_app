import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
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
      body: HomeScreenUI(),
    );
  }
}

class HomeScreenUI extends StatelessWidget {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                RecentChat(),
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
                        onTap: () => sendMessage(messageController.text),
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
    print("Message to be sent " + message);
  }
}
