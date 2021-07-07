import 'package:flutter/material.dart';
import 'package:lebanon_usdt/components/expandable_fab.dart';
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
    return Scaffold(
      appBar: AppBar(
          // shape: Border(bottom: BorderSide(color: Colors.orange, width: 20)),
          bottom: PreferredSize(
        child: Text('s'),
        preferredSize: Size.fromHeight(20),
      )),
      floatingActionButton: ExpandableFab(
        distance: 112,
        children: [
          ActionButton(
              icon: const Icon(Icons.sell),
              onPressed: () => Navigator.pushNamed(context, '/makeRequest',
                  arguments: 'sell')),
          ActionButton(
              icon: const Icon(Icons.shopping_bag),
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
                    Color(0xff1cd0a3),
                    Color(0xff36e786)
                  ], // red to yellow
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
              ),
            ),
            // ListTile(title: Text('Driver Menu')),
            // ListTile(title: Text('B')),
            SizedBox(height: 300),
            TextButton(
                onPressed: () {},
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
        backgroundColor: Color(0xfff3f3f3),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.sell),
            label: 'Selling',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag,
            ),
            label: 'Buying',
          ),
        ],
        onTap: _onItemTapped,
        selectedItemColor: Color(0xff1cd0a3),
      ),
    );
  }
}
