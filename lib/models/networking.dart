import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({this.url});
  String? url;

  Map<String, dynamic>? finaldata;

  Future<dynamic> getdata() async {
    try {
      Response response = await get(Uri.parse(url!));

      if (response.statusCode == 200) {
        String data = response.body;
        finaldata = jsonDecode(data);
        print("check");
        return jsonDecode(data);
      } else {
        return response.statusCode;
      }
    } catch (e) {
      print(e);
    }
  }
}
