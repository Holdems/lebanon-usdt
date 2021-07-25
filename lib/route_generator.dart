import 'package:flutter/material.dart';
import 'package:lebanon_usdt/filter.dart';
import 'package:lebanon_usdt/home.dart';
import 'package:lebanon_usdt/login.dart';
import 'package:lebanon_usdt/make_request_screen.dart';
import 'package:lebanon_usdt/requests_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/makeRequest':
        var data = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => MakeRequestScreen(title: data));
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/login':
        return MaterialPageRoute(builder: (_)=>Login());
      case '/filter':
        return MaterialPageRoute(builder: (_)=>Filter());
      //Passing arguments from screen to another
      // case '/merchantHomeScreen':
      //   return MaterialPageRoute(
      //       builder: (_) => MerchantHomeScreen(token: args));

      default:
        //if there is no such named route in the switch statement, e.g /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("Error"),
        ),
      );
    });
  }
}
