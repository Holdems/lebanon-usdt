import 'package:http/http.dart' as http;
import 'dart:convert';

 postBr(
  String user,
  int amount,
  double rate,
  int totalPrice,
) async {
  var uriPostBuyReq = Uri.parse('https://lebanon-usdt.azurewebsites.net/br/');
  Map<String, Object> postBrBody = {
    "user": user,
    "amount": amount,
    "rate": rate,
    "total_price": totalPrice
  };
  var postBrBodyJson = json.encode(postBrBody);
  http.Response responseBrPost = await http.post(uriPostBuyReq,
      body: postBrBodyJson, headers: {"content-type": "application/json"});
  print(responseBrPost.statusCode);
}
