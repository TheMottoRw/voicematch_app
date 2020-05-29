import 'dart:convert';

import 'package:http/http.dart';

class Contacts{

  static Future create(String name,String phone) async{
    String url = 'http://192.168.56.1/contacts';
    Map<String,String> js = {"name":name,"phone":phone};

    Response response = await post(url,headers: null,body: js);
    int statusCode = response.statusCode;
    print("Response data "+response.body+" Status $statusCode");
    return response.body;
  }

  dynamic loadContacts() async{
    String url = 'http://192.168.56.1:5000/contacts';
    Response response = await get(url);

    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String dataBody = response.body;
    dynamic json = jsonDecode(response.body);
    print("HTTP Response ContentType "+contentType+" Data "+dataBody+" Status code $statusCode");
    return json;
  }
  dynamic loadContactsById(int id) async{
    String url = 'http://192.168.56.1:5000/contact/$id';
    Response response = await get(url);

    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String dataBody = response.body;
    dynamic json = jsonDecode(response.body);
    print("HTTP Response ContentType "+contentType+" Data "+dataBody+" Status code $statusCode");
    return json;
  }
  static Future update(int id,String name,String phone) async{
    String url = 'http://192.168.56.1:5000/contact/$id';
    Map<String,String> js = {"name":name,"phone":phone};

    Response response = await post(url,headers: null,body: js);
    int statusCode = response.statusCode;
    print("Response data "+response.body+" Status $statusCode");
    return response.body;
  }

  static Future verify(int id,String code) async{
    String url = 'http://192.168.56.1:5000/code/$id';
    Map<String,String> js = {"code":code};

    Response response = await post(url,headers: null,body: js);
    int statusCode = response.statusCode;
    print("Response data "+response.body+" Status $statusCode");
    return response.body;
  }

}