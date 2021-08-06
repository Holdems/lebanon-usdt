import 'package:flutter/material.dart';
import 'package:lebanon_usdt/colors.dart';
import 'package:lebanon_usdt/components/rounded_button.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            child: Image.asset("assets/images/green_circle.png"),
            width: size.width * 2,
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset("assets/images/main_bottom.png"),
            width: size.width * 0.25,
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("assets/images/main_top.png"),
            width: size.width * 0.3,
          ),
          child,
        ],
      ),
    );
  }
}
