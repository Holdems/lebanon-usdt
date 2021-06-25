import 'package:flutter/material.dart';
import 'package:lebanon_usdt/components/expandable_fab.dart';
import 'package:lebanon_usdt/sell_requests_page.dart';

import 'buy_requests_page.dart';

class HomeScreen extends StatefulWidget {
  // final String token;
  // MerchantHomeScreen({Key key, @required this.token}) : super(key: key);
  static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];
  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    super.initState();
  }

  int _currentIndex = 0;
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
    _currentIndex = selectedIndex;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ExpandableFab(distance: 112,children: [
        ActionButton(
          onPressed: () => widget._showAction(context, 0),
          icon: const Icon(Icons.format_size),
        ),
        ActionButton(
          onPressed: () => widget._showAction(context, 1),
          icon: const Icon(Icons.insert_photo),
        ),
        ActionButton(
          onPressed: () => widget._showAction(context, 2),
          icon: const Icon(Icons.videocam),
        ),
      ],
      ),floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Hello')),
            ListTile(title: Text('A')),
            ListTile(title: Text('B')),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          BuyRequestsPage(),
          SellRequestsPage(),
        ],
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.green,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.sell),
            label: 'Sell',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag,
            ),
            label: 'Buy',
          ),
        ],
        onTap: _onItemTapped,
        selectedItemColor: Colors.amber,
      ),
    );
  }
}
