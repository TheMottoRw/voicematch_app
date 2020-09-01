import 'package:shared_preferences/shared_preferences.dart';
import 'package:voicematch/models/user_model.dart';
import 'package:voicematch/screens/Chat.dart';
import 'package:voicematch/screens/Confirm.dart';
import 'package:voicematch/screens/Contacts.dart';

class Message{
  final User chat_with;
  final String caption;
  final String time;
  final bool isLiked;
  final bool unread;
  Message({this.chat_with,this.caption,this.time,this.isLiked,this.unread});

  factory Message.fromJson(Map<String, dynamic> json){
    var senderInfo = json['receiver_info'];
    return Message(
      chat_with: User(id:senderInfo['id'],name:senderInfo['name'],imageUrl:'assets/logo.png'),
      caption: json['caption'],
      time: json['regdate'],
      isLiked: false,
      unread: true,
    );
  }

  static final User currentUser = User(id:1,name:'Asua',imageUrl:'assets/asua.png',);

  static final User kabaka = User(id:2,name:'Kabaka',imageUrl: 'assets/kabaka.png');

  static final User imenye = User(id:3,name:'Imenye',imageUrl: 'assets/imenye_logo.png');


  static final User john = User(id:4,name:'Jogn',imageUrl: 'assets/kabaka.png');

  static final User james = User(id:5,name:'John',imageUrl: 'assets/imenye_logo.png');

  static final User kamanzi = User(id:6,name:'Kamanzi',imageUrl:'assets/asua.png',);

  static final User aline = User(id:7,name:'Aline',imageUrl:'assets/asua.png',);


  static final List<User> favorites = [aline,currentUser,kabaka];
  static List<Message> chats = [
    Message(
     chat_with: james,
    time:'16:19',
    caption:'Hello,how are you doing',
    isLiked: false,
    unread: true,
    ),
  ];
}