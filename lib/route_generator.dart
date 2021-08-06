import 'package:flutter/material.dart';
import 'package:lebanon_usdt/filter.dart';
import 'package:lebanon_usdt/home.dart';
import 'package:lebanon_usdt/login.dart';
import 'package:lebanon_usdt/make_request_screen.dart';
import 'package:lebanon_usdt/requests_screen.dart';
import 'package:lebanon_usdt/screens/login/login_screen.dart';
import 'package:lebanon_usdt/screens/signup/signup_screen.dart';
import 'package:lebanon_usdt/screens/welcome/welcome_screen.dart';
import 'package:lebanon_usdt/test.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/welcomeScreen':
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case '/homeScreen':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/signUpScreen':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/loginScreen':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/makeRequest':
        var data = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => MakeRequestScreen(title: data));
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/filter':
        return MaterialPageRoute(builder: (_) => Filter());
      case '/test':
        return MaterialPageRoute(builder: (_) => Test());
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
