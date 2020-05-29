import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:voicematch/models/message_model.dart';

class RecentChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {//Color(0xFFFFEFEE)
    // TODO: implement build
    return Expanded(
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
            itemBuilder: (BuildContext context, index) {
              final Message chat = Message.chats[index];
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
                        backgroundImage: AssetImage(chat.sender.imageUrl),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            chat.sender.name,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Text(
                              chat.text,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                          chat.time,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0,),
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

                    ],
                  )
                ],
              ),
              );
            },
            itemCount: Message.chats.length,
          )
        )
      ),
    );
  }
}
