import 'package:flutter/material.dart';
import 'package:lebanon_usdt/colors.dart';
import 'package:lebanon_usdt/components/expandable_fab.dart';
import 'package:lebanon_usdt/constants.dart';
import 'package:lebanon_usdt/screens/welcome/welcome_screen.dart';
import 'package:lebanon_usdt/sell_requests_page.dart';

import 'buy_requests_page.dart';

class HomeScreen extends StatefulWidget {
  // final String token;
  // MerchantHomeScreen({Key key, @required this.token}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    super.initState();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int selectedIndex) {
    setState(() {
      if (selectedIndex == _selectedIndex)
        scrollToMin();
      else
        _selectedIndex = selectedIndex;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    SellRequestsPage(),
    BuyRequestsPage()
  ];

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    var selectedRange = RangeValues(0.2, 0.8);
    return Theme(
      data: ThemeData(primaryIconTheme: IconThemeData(color: Colors.grey)),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              tooltip: "Filter",
              onPressed: () {
                Navigator.pushNamed(context, '/filter');
              },
              icon: Icon(Icons.filter_alt),
            )
          ],
          backgroundColor: secondaryColor,
          // title: Text("Buy here",style: TextStyle(color: Colors.grey),),
          // shape: Border(bottom: BorderSide(color: Colors.orange, width: 20)),
          //     bottom: PreferredSize(
          //   child: Text(''),
          //   preferredSize: Size.fromHeight(0),
          // )
        ),
        floatingActionButton: ExpandableFab(
          distance: 112,
          children: [
            ActionButton(
                icon: const Icon(
                  Icons.sell,
                  color: secondaryColor,
                ),
                onPressed: () => Navigator.pushNamed(context, '/makeRequest',
                    arguments: 'sell')),
            ActionButton(
                icon: const Icon(
                  Icons.shopping_bag,
                  color: secondaryColor,
                ),
                onPressed: () => Navigator.pushNamed(context, '/makeRequest',
                    arguments: 'buy')),
            // ActionButton(
            //   onPressed: () => widget._showAction(context, 2),
            //   icon: const Icon(Icons.videocam),
            // ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Text(''),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(
                        0.8, 0.0), // 10% of the width, so there are ten blinds.
                    colors: <Color>[
                      primaryColor,
                      primaryLightColor
                    ], // red to yellow
                    tileMode: TileMode
                        .repeated, // repeats the gradient over the canvas
                  ),
                ),
              ),
              // ListTile(title: Text('Driver Menu')),
              // ListTile(title: Text('B')),
              SizedBox(height: 300),
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(pageBuilder: (BuildContext context,
                            Animation animation, Animation secondaryAnimation) {
                          return WelcomeScreen();
                        }, transitionsBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                            Widget child) {
                          return new SlideTransition(
                            position: new Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        }),
                        (Route route) => false);
                  },
                  child: Text('Sign out', style: TextStyle(fontSize: 20))),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          //0xfff3f3f3
          backgroundColor: secondaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Buy',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.sell,
              ),
              label: 'Sell',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.task), label: "My Requests")
          ],
          onTap: _onItemTapped,
          selectedItemColor: primaryColor,
        ),
      ),
    );
  }
}
