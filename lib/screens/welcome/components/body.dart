import 'package:flutter/material.dart';
import 'package:lebanon_usdt/colors.dart';
import 'package:lebanon_usdt/components/rounded_button.dart';
import 'package:lebanon_usdt/screens/welcome/components/background.dart';


class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome",
                style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold, fontSize: size.width * 0.06),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Image.asset(
                "assets/images/main_diamond.png",
                scale: size.width * 0.01,
              ),
              SizedBox(height: size.width * 0.2),
              RoundedButton(
                  text: "LOGIN",
                  press: () {
                    Navigator.pushNamed(context, '/loginScreen');
                  }),
              RoundedButton(text: "SIGNUP", press: () {
                Navigator.pushNamed(context, '/signUpScreen');
              },color: primaryLightColor,)
            ],
          ),
        ));
  }
}