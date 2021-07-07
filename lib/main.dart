import 'package:flutter/material.dart';
import 'package:lebanon_usdt/route_generator.dart';


main() {
  runApp(MaterialApp(
    initialRoute: '/',
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}