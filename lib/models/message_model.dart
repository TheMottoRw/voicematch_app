import 'package:voicematch/models/user_model.dart';

class Message{
  final User sender;
  final String text;
  final String time;
  final bool isLiked;
  final bool unread;
  Message({this.sender,this.text,this.time,this.isLiked,this.unread});

  static final User currentUser = User(id:1,name:'Asua',imageUrl:'assets/asua.png',);

  static final User kabaka = User(id:2,name:'Kabaka',imageUrl: 'assets/kabaka.png');

  static final User imenye = User(id:3,name:'Imenye',imageUrl: 'assets/imenye_logo.png');


  static final User john = User(id:4,name:'Jogn',imageUrl: 'assets/kabaka.png');

  static final User james = User(id:5,name:'John',imageUrl: 'assets/imenye_logo.png');

  static final User kamanzi = User(id:6,name:'Kamanzi',imageUrl:'assets/asua.png',);

  static final User aline = User(id:7,name:'Aline',imageUrl:'assets/asua.png',);


  static final List<User> favorites = [aline,currentUser,kabaka];
  static final List<Message> chats = [
    Message(
     sender: james,
    time:'16:19',
    text:'Hello,how are you doing',
    isLiked: false,
    unread: true,
    ),
    Message(
      sender: kabaka,
      time:'16:25',
      text:'I am good how about you',
      isLiked: true,
      unread: true,
    ),
    Message(
      sender: aline,
      time:'12:45',
      text:'Hey Dear Asua',
      isLiked: true,
      unread: true,
    ),
    Message(
      sender: james,
      time:'08:03',
      text:'Hello,how are you doing',
      isLiked: false,
      unread: false,
    ),
    Message(
      sender: john,
      time:'06:33',
      text:'Salama umusaza',
      isLiked: false,
      unread: true,
    ),
    Message(
      sender: currentUser,
      time:'12:49',
      text:'Hi,are you good',
      isLiked: false,
      unread: true,
    ),
    Message(
      sender: james,
      time:'15:29',
      text:'Wassup kinywanyi',
      isLiked: false,
      unread: true,
    ),
    Message(
      sender: kamanzi,
      time:'16:19',
      text:'Salama,wangu',
      isLiked: false,
      unread: true,
    ),
  ];
}