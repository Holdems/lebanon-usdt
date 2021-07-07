import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lebanon_usdt/models/request/sell_request.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


int s = 0;

class SellRequestsPage extends StatefulWidget {
  const SellRequestsPage({Key? key}) : super(key: key);

  @override
  _SellRequestsPageState createState() => _SellRequestsPageState();
}

class _SellRequestsPageState extends State<SellRequestsPage> {
  // https://lebanon-usdt.azurewebsites.net/sr/

  Future<List<SellRequest>> getSellRequests() async {
    var url = Uri.parse('https://lebanon-usdt.azurewebsites.net/sr/');
    http.Response response = await http.get(url, headers: {
      "content-type": "application/json",
    });
    print(1);
    print(response.statusCode);
    var jsonData = json.decode(response.body);
    print(jsonData);
    List<SellRequest> requests = [];
    for (var request in jsonData) {
      SellRequest _request = SellRequest(
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
    s+=1;
    print("s is now $s");
    return Container(
      child: FutureBuilder(
          future: getSellRequests(),
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
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Card(
                              color: Colors.lightBlueAccent,
                              shadowColor: Colors.blueAccent,
                              child: ExpansionTile(
                                leading: Text("Selling"),
                                title: Text("100 USDT\nBeirut"),
                                subtitle: Text("+ 1.6%"),
                                // trailing: Text("s"),
                                children: [
                                  Text("Hello"),
                                  Text("ss"),
                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    ElevatedButton(onPressed: (){}, child: Row(
                                      children: [
                                        Icon(Icons.chat),
                                        Text(" Message on WhatsApp"),
                                      ],
                                    ))
                                  ],)
                                ],
                              )
                          ),
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
