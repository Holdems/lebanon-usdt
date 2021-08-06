import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lebanon_usdt/colors.dart';
import 'package:lebanon_usdt/models/request/sell_request.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final ScrollController _scrollController = ScrollController();

scrollToMin() {
  _scrollController.animateTo(_scrollController.position.minScrollExtent,
      duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
}

int s = 0;

class SellRequestsPage extends StatefulWidget {
  const SellRequestsPage({Key? key}) : super(key: key);

  @override
  _SellRequestsPageState createState() => _SellRequestsPageState();
}

class _SellRequestsPageState extends State<SellRequestsPage> {
  // https://lebanon-usdt.azurewebsites.net/sr/
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
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
    s += 1;
    print("s is now $s");
    return Container(
      child: FutureBuilder(
          future: getSellRequests(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                    child: SpinKitCircle(
                  color: primaryColor,
                )),
              );
            } else {
              return RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () {
                  return getSellRequests().then((request) {
                    setState(() => null);
                  });
                },
                child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: primaryColor,
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    leading: CircleAvatar(
                                      backgroundColor: secondaryColor,
                                      child: Icon(
                                        Icons.sell,
                                        color: primaryColor,
                                      ),
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${snapshot.data[index].amount} USDT",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        snapshot.data[index].rate <= 0
                                            ? Text(
                                                "${snapshot.data[index].rate.toString()}%",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              )
                                            : Text(
                                                "+${snapshot.data[index].rate}%",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                      ],
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Beirut",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text(
                                          "Total Price: \$${snapshot.data[index].totalPrice.toString()}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                    // trailing: Text("s"),
                                    children: [
                                      ListTile(
                                        title: Text(
                                          "${snapshot.data[index].username.toString()}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        leading: CircleAvatar(
                                          backgroundColor: secondaryColor,
                                          foregroundImage: AssetImage(
                                              'assets/images/portrait.png'),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          secondaryColor)),
                                              onPressed: () {},
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/whatsapp.png',
                                                    scale: 35,
                                                  ),
                                                  Text(
                                                    " Message on WhatsApp",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      );
                    }),
              );
            }
          }),
    );
  }
}
