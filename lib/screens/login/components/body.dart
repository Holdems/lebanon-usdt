import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lebanon_usdt/components/already_have_an_account_acheck.dart';
import 'package:lebanon_usdt/components/rounded_button.dart';
import 'package:lebanon_usdt/components/rounded_input_field.dart';
import 'package:lebanon_usdt/components/rounded_password_field.dart';
import 'package:lebanon_usdt/screens/login/components/background.dart';

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
            "LOGIN",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: size.width * 0.05),
          ),
          SizedBox(height: size.height * 0.03),
          SvgPicture.asset(
            "assets/icons/yellow_coin.svg",
            height: size.height * 0.35,
          ),
          SizedBox(height: size.height * 0.03),
          RoundedInputField(
            hintText: "Your Email",
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            onChanged: (value) {},
          ),
          RoundedButton(
            text: "LOGIN",
            press: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/homeScreen', (route) => false);
            },
          ),
          SizedBox(height: size.height * 0.03),
          AlreadyHaveAnAccountCheck(press: () {
            Navigator.pushReplacementNamed(context, '/signUpScreen');
          }),
        ],
      ),
    ));
  }
}
