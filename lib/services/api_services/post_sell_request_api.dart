import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<http.Response> postSr(
  String user,
  int amount,
  double rate,
  int totalPrice,
) async {
  var uriPostSellReq = Uri.parse('https://lebanon-usdt.azurewebsites.net/sr/');
  Map<String, Object> postSrBody = {
    "user": user,
    "amount": amount,
    "rate": rate,
    "total_price": totalPrice
  };
  var postSrBodyJson = json.encode(postSrBody);
  http.Response responseSrPost = await http.post(uriPostSellReq,
      body: postSrBodyJson, headers: {"content-type": "application/json"});
  print(responseSrPost.statusCode);
  return responseSrPost;
}
