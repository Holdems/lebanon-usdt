import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lebanon_usdt/models/request/buy_request.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import  'package:http/http.dart' as http;

class BuyRequestsPage extends StatefulWidget {
  const BuyRequestsPage({Key? key}) : super(key: key);

  @override
  _BuyRequestsPageState createState() => _BuyRequestsPageState();
}

class _BuyRequestsPageState extends State<BuyRequestsPage> {

  // https://lebanon-usdt.azurewebsites.net/br/

  Future<List<BuyRequest>> getBuyRequests() async {
    var uri =
    Uri(scheme: 'https', host: '//lebanon-usdt.azurewebsites.net', path: '/br/');
    var data = await http.get(uri, headers: {
      "content-type": "application/json",
    });
    var jsonData = json.decode(data.body);
    List<BuyRequest> requests = [];
    for (var request in jsonData) {
      BuyRequest _request = BuyRequest(
        request['rate'],
        request['amount'],
        request['total_price'],
        request['user']
      );
      requests.add(_request);
    }
    return requests;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getBuyRequests(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.data == null) {
            return Container(
              child: Center(
                  child: SpinKitCircle(
                    color: Colors.greenAccent,
                  )),
            );
          }
          else {
            return Card(
              child: ListTile(
                leading: snapshot.data['rate'],
              ),
            );
          }
        }
      ),
    );
  }
}


