import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

/* GLOBAIS */
var token;
var user;

String mainUrl = "http://192.168.0.9:3000";

Map<String, String> headers = {};

class Session {

  Future<Map> get(String url) async {
    print(headers);
    http.Response response = await http.get(url, headers: headers);
    updateCookie(response);
    return json.decode(response.body);
  }

  Future<Map> post(String url, dynamic data) async {
    http.Response response = await http.post(url, body: data, headers: headers);
    updateCookie(response);
    return json.decode(response.body);
  }

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}