import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voicematch/api/ApiMessages.dart';
import 'package:voicematch/models/message_model.dart';
import 'package:voicematch/widgets/recent_chats.dart';
import 'package:medcorder_audio/medcorder_audio.dart';

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
  int receiver = 0;
  String receiverName = "";
  TextEditingController messageController = TextEditingController();

  MedcorderAudio audioModule = new MedcorderAudio();
  bool canRecord = false;
  double recordPower = 0.0;
  double recordPosition = 0.0;
  bool isRecord = false;
  bool isPlay = false;
  double playPosition = 0.0;
  String file = "";
  double playProgress = 0;
  String recordedAudioFile = "";


  @override
  initState() {
    super.initState();
    audioModule.setCallBack((dynamic data) {
      _onEvent(data);
      print("Data check "+data.toString() +" Acess URL "+data['url']);
      recordedAudioFile = data['url'];
    });
    _initSettings();
  }

  Future _initSettings() async {
    final String result = await audioModule.checkMicrophonePermissions();
    if (result == 'OK') {
      await audioModule.setAudioSettings();
      setState(() {
        canRecord = true;
      });
    }
    return;
  }

  Future _startRecord() async {
    try {
      DateTime time = new DateTime.now();
      setState(() {
        file = time.millisecondsSinceEpoch.toString();
      });
      final String result = await audioModule.startRecord(file);
      setState(() {
        isRecord = true;
      });
      print('startRecord: ' + result);
    } catch (e) {
      file = "";
      print('startRecord: fail');
    }
  }

  Future _stopRecord() async {
    try {
      final String result = await audioModule.stopRecord();
      print('stopRecord: ' + result);
      setState(() {
        isRecord = false;
      });
    } catch (e) {
      print('stopRecord: fail');
      setState(() {
        isRecord = false;
      });
    }
  }

  Future _startStopPlay() async {
    if (isPlay) {
      await audioModule.stopPlay();
    } else {
      await audioModule.startPlay({
        "file": file,
        "position": 0.0,
      });
    }
  }

  void _onEvent(dynamic event) {
    if (event['code'] == 'recording') {
      double power = event['peakPowerForChannel'];
      setState(() {
        recordPower = (60.0 - power.abs().floor()).abs();
        recordPosition = event['currentTime'];
      });
    }
    if (event['code'] == 'playing') {
      String url = event['url'];
      setState(() {
        playPosition = event['currentTime'];
        playProgress = event['currentTime'] /event['duration'];
        isPlay = true;
      });
    }
    if (event['code'] == 'audioPlayerDidFinishPlaying') {
      setState(() {
        playPosition = 0.0;
        playProgress = 0.0;
        isPlay = false;
      });
    }
  }

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
      body: Column(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                canRecord? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        isRecord?new Text('Rec: ' + recordPosition.round().toString()+"s"):new Text(''),
                        //new Text('power: ' + recordPower.toString()),

                        isPlay?new Text('Playing: ' + playPosition.round().toString()+"s"):new Text(''),
                        file!=""?Row(
                          children: [
                            new InkWell(
                              child: isPlay? new Icon(Icons.pause_circle_filled,color: Colors.blueGrey,size: 50.0,): new Icon(Icons.play_circle_filled,color: Colors.blueGrey,size: 50.0,),
                              onTap: (){
                                if (!isRecord && file.length > 0) {
                                  _startStopPlay();
                                }
                              },
                            ),
                            new LinearPercentIndicator(
                              width: 250.0,
                              alignment: MainAxisAlignment.center,
                              lineHeight: 20.0,
                              percent: playProgress,
                              progressColor: Colors.blueGrey,
                            ),
                            new InkWell(
                              child: file!=""? new Icon(Icons.delete_outline,color: Colors.brown,size: 40.0,): Text(''),
                              onTap: (){
                                //call delete file

                              },
                            ),
                          ],
                        ):Text(''),
                      ],
                    )
                    : Text(
                      'Microphone Access Disabled.\nYou can enable access in Settings',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueGrey,fontSize: 10.0),
                    ),
                    //end recording part
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                color: Colors.blueGrey),
                            child: InkWell(
                              child: isRecord? new Icon(Icons.record_voice_over,color: Colors.white): new Icon(Icons.keyboard_voice,color: Colors.white),
                              onTap: (){
                                if(!isRecord){
                                  _startRecord();
                                  isRecord = true;
                                } else {
                                  _stopRecord();
                                  isRecord = false;
                                }
                              },
                            ) ,
                          ),
                    Container(
                      width: 250,
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
                          sendMessage(recordedAudioFile,messageController.text);
                          messageController.clear();
                          },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    ])
    );
  }

  void sendMessage(String voice,String message) {
    //call message sender api
    print("Message to be sent Voices: $voice Message:  " + message);
    // print("Message to be sent Voices: $voice Message:  " + message+" Sender $sender Receiver $receiver");

    var sender = _getSession(),receiver = this.receiver.toString(),voices = "";
    const platform = const MethodChannel("toast.flutter.io/toast");
    sender.then((sender){
        var resp = ApiMessages.create(sender, voice, message, receiver);
        print("Message to be sent Voices: $voice Message:  " + message+" Sender $sender Receiver $receiver");
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
