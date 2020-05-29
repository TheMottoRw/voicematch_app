import 'dart:convert';
import 'package:http/http.dart';

class ApiMessages{

  static Future create(String sender,String voices,String caption,String receiver) async{
    String url = 'http://192.168.56.1/chats';
    Map<String,String> js = {"sender":sender,"voices":voices,"caption":caption,"receiver":receiver};

    Response response = await post(url,headers: null,body: js);
    int statusCode = response.statusCode;
    print("Response data "+response.body+" Status $statusCode");
    return response.body;
  }

  dynamic loadChats() async{
    String url = 'http://192.168.56.1:5000/chats';
    Response response = await get(url);

    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String dataBody = response.body;
    dynamic json = jsonDecode(response.body);
    print("HTTP Response ContentType "+contentType+" Data "+dataBody+" Status code $statusCode");
    return json;
  }
  dynamic loadChatsById(int id) async{
    String url = 'http://192.168.56.1:5000/chat/$id';
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
    String url = 'http://192.168.56.1:5000/chat/$id';
    Map<String,String> js = {"name":name,"phone":phone};

    Response response = await post(url,headers: null,body: js);
    int statusCode = response.statusCode;
    print("Response data "+response.body+" Status $statusCode");
    return response.body;
  }

}