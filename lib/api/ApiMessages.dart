import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voicematch/api/SampleRequest.dart';
import 'package:voicematch/models/message_model.dart';

class ApiMessages{
  static String hostUrl  = SampleHttpRequest.host;

  static Future<String> create(String sender,String voices,String caption,String receiver) async{
    String url = hostUrl+'/chatting';
    // Map<String,String> js = {"sender":sender,"voices":voices,"caption":caption,"receiver":receiver};
    //
    // Response response = await post(url,headers: null,body: js);
    // int statusCode = response.statusCode;
    
    //uploading  request
    var req = MultipartRequest('POST',Uri.parse(url));
    req.files.add(await MultipartFile.fromPath('voices', voices));
    req.fields['sender'] = sender;
    req.fields['caption'] = caption;
    req.fields['receiver'] = receiver;
    var res = await req.send();
    int statusCode = res.statusCode;

    print("Response data "+res.reasonPhrase+" Status $statusCode");
    return res.reasonPhrase;
  }

  static Future<List<Message>> loadChats(String sender,String receiver) async{
    String url = hostUrl+'/chatting?sender=$sender&receiver=$receiver';
    Response response = await get(url);
    List<Message> chatList = List<Message>();
    int statusCode = response.statusCode;
    if(statusCode == 200) {
      Map<String, String> headers = response.headers;
      String contentType = headers['content-type'];
      String dataBody = response.body;
      final jsonItems = jsonDecode(response.body).cast<Map<String,dynamic>>();
      chatList = jsonItems.map<Message>((chat){
        return Message.fromJson(chat);
      }).toList();
    }
    return chatList;
  }
  static Future<List<Message>> loadRecentChats() async{
    String user = '',url = '';
    Response response;
    List<Message> chatList = List();
    //read user session id
    SharedPreferences sh = await SharedPreferences.getInstance();
    user = sh.getString("sessid") ?? "";

      url = hostUrl + '/recent?sender=$user';
      response = await get(url);
      chatList = List<Message>();
      int statusCode = response.statusCode;
      if(statusCode == 200) {
        Map<String, String> headers = response.headers;
        String contentType = headers['content-type'];
        String dataBody = response.body;
        final jsonItems = jsonDecode(response.body).cast<Map<String, dynamic>>();
        chatList = jsonItems.map<Message>((chat) {
          return Message.fromJson(chat);
        }).toList();
      }
    return chatList;
  }
  dynamic loadChatsById(int id) async{
    String url = hostUrl+'/chat/$id';
    Response response = await get(url);

    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String dataBody = response.body;
    dynamic json = jsonDecode(response.body);
    print("HTTP Response ContentType "+contentType+" Data "+dataBody+" Status code $statusCode");
    return json;
  }
  static Future delete(int id,String name,String phone) async{
    String url = hostUrl+'/chat/$id';
    Map<String,String> js = {"name":name,"phone":phone};

    Response response = await post(url,headers: null,body: js);
    int statusCode = response.statusCode;
    print("Response data "+response.body+" Status $statusCode");
    return response.body;
  }

  static Future<String> _getSession() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String userId = sh.getString("sessid") ?? "";
    return userId;
  }
}