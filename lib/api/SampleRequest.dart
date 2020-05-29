import 'package:http/http.dart';
import 'dart:convert';
class SampleHttpRequest{
  void _getRequest() async{
    String url = 'http://192.168.56.1/flutter/request.php?cate=Gateway';
    Response response = await get(url);

    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String dataBody = response.body;
    print("HTTP Response ContentType "+contentType+" Data "+dataBody+" Status code $statusCode");
  }

  dynamic _postRequest() async{
    String url = 'http://192.168.56.1/flutter/request.php?cate=post';
    Map<String,String> js = {"title":"Hello asua developer","body":"We really appreciate your work","id":'12'};

    Response response = await post(url,headers: null,body: js);
    int statusCode = response.statusCode;
    dynamic json = jsonDecode(response.body);

    print("Response data "+json['title']+" Status $statusCode");
    return json;
  }
}