import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:voicematch/models/message_model.dart';

class ChatRow extends StatelessWidget {
  // final String image,name,caption,time;
  // final bool unread;
  final List<Message> chats;
  // ChatRow({Key key,this.image,this.name,this.caption,this.time,this.unread}) : super(key: key);
  ChatRow({Key key,this.chats}) : super(key: key);
  @override
  Widget build(BuildContext context) {//Color(0xFFFFEFEE)
    // TODO: implement build
    return Container(
        child: Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5.0),
              topLeft: Radius.circular(5.0),
            )),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, index) {
              print(chats.toString()+" - Index "+index.toString());
              final Message chat = this.chats[index];
              return Container(
                margin: EdgeInsets.only(top: 5.0,bottom: 5.0,right: 20.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              decoration: BoxDecoration(
                  color: chat.unread? Color.fromRGBO(197, 211, 237, 0.45):Color.fromRGBO(197, 237, 211, 0.7),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(30.0),
                  )),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 35.0,
                        backgroundImage: AssetImage(chat.chat_with.imageUrl),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            chat.chat_with.name,
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            //width: MediaQuery.of(context).size.width * 0.45,
                            child: Text(
                              chat.caption,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[

                      chat.unread?
                      Container(
                        width: 40.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        alignment: Alignment.center,
                        child: Text('NEW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),),
                      )
                          :SizedBox.shrink(),
                      SizedBox(height: 8.0,),
                      Text(
                        chat.time.substring(5,22),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              );
            },
            itemCount: chats.length,
          )
        )
        ),
    ),
    );
  }
}
