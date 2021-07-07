import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lebanon_usdt/models/request/buy_request.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import  'package:http/http.dart' as http;

int b = 0;
class BuyRequestsPage extends StatefulWidget {
  const BuyRequestsPage({Key? key}) : super(key: key);

  @override
  _BuyRequestsPageState createState() => _BuyRequestsPageState();
}

class _BuyRequestsPageState extends State<BuyRequestsPage> {

  // https://lebanon-usdt.azurewebsites.net/br/
  Future<List<BuyRequest>> getBuyRequests() async {
    var url = Uri.parse('https://lebanon-usdt.azurewebsites.net/br/');
    http.Response response = await http.get(url, headers: {
      "content-type": "application/json",
    });
    print(1);
    print(response.statusCode);
    var jsonData = json.decode(response.body);
    print(jsonData);
    List<BuyRequest> requests = [];
    for (var request in jsonData) {
      BuyRequest _request = BuyRequest(
        request['id'],
        request['user'],
        request['amount'],
        request['rate'],
        request['total_price'],
      );
      requests.add(_request);
    }
    print(requests);
    return requests;
  }


  @override
  Widget build(BuildContext context) {
    b +=1;
    print("t is now $b");
    return Container(
      child: FutureBuilder(
        future: getBuyRequests(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.data == null) {
            return Container(
              child: Center(
                  child: SpinKitCircle(
                    color: Colors.lightBlueAccent,
                  )),
            );
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                return Column(
                  children: [
                    SizedBox(height: 10,),
                    Card(
                      color: Colors.teal,
                      shadowColor: Colors.blueAccent,
                      child: InkWell(
                        child: SizedBox(
                          height: 100,
                          width: 300,
                          child: Column(
                            children: [
                              Text(snapshot.data[index].id.toString()),
                              Text(snapshot.data[index].username),
                              Text(snapshot.data[index].amount.toString()),
                              Text(snapshot.data[index].rate.toString()),
                              Text(snapshot.data[index].totalPrice.toString()),
                              Text(snapshot.data[index].toStringType()),
                            ],
                          ),
                        ),
                      )
                    )
                  ],
                );
              }
            );
          }
        }
      ),
    );
  }
}