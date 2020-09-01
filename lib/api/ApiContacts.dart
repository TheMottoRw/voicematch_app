import 'dart:convert';

import 'package:http/http.dart';
import 'package:voicematch/api/SampleRequest.dart';
import 'package:voicematch/models/user_model.dart';

class ApiContacts {
  static String hostUrl = SampleHttpRequest.host;

  static Future<String> create(String name, String phone) async {
    String url = hostUrl + '/contacts';
    print("Login URL $url");
    Map<String, String> js = {"name": name, "phone": phone, "appid": "Abc@123"};

    Response response = await post(url, headers: null, body: js);
    int statusCode = response.statusCode;
    print("Response data " + response.body + " Status $statusCode");

    return response.body;
  }

  static Future<List<User>> loadContacts() async {
    String url = hostUrl + '/contacts';
    Response response = await get(url);
    List<User> userList = List<User>();
    int statusCode = response.statusCode;
    if (statusCode == 200) {
      Map<String, String> headers = response.headers;
      String contentType = headers['content-type'];
      String dataBody = response.body;
      final jsonItems = jsonDecode(response.body).cast<Map<String, dynamic>>();
      userList = jsonItems.map<User>((user) {
        return User.fromJson(user);
      }).toList();
    }
    print("HTTP Response "+userList.toString());

    return userList;
  }

  dynamic loadContactsById(int id) async {
    String url = hostUrl + '/contact/$id';
    Response response = await get(url);

    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String dataBody = response.body;
    dynamic json = jsonDecode(response.body);
    print("HTTP Response ContentType " +
        contentType +
        " Data " +
        dataBody +
        " Status code $statusCode");
    return json;
  }

  static Future update(int id, String name, String phone) async {
    String url = hostUrl + '/contact/$id';
    Map<String, String> js = {"name": name, "phone": phone};

    Response response = await post(url, headers: null, body: js);
    int statusCode = response.statusCode;
    print("Response data " + response.body + " Status $statusCode");
    return response.body;
  }

  static Future<String> verify(String id, String code) async {
    String url = hostUrl + '/codes';
    Map<String, String> js = {"code": code, "phone": '$id'};

    Response response = await post(url, headers: null, body: js);
    int statusCode = response.statusCode;
    print("Response data " + response.body + " Status $statusCode");
    return response.body;
  }
}
