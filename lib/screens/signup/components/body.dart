import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lebanon_usdt/colors.dart';
import 'package:lebanon_usdt/components/already_have_an_account_acheck.dart';
import 'package:lebanon_usdt/components/rounded_button.dart';
import 'package:lebanon_usdt/components/rounded_input_field.dart';
import 'package:lebanon_usdt/components/rounded_password_field.dart';
import 'package:lebanon_usdt/screens/signup/components/background.dart';

import 'package:http/http.dart' as http;

final _formKey = GlobalKey<FormState>();

final TextEditingController emailController = TextEditingController();
final TextEditingController password1Controller = TextEditingController();
final TextEditingController password2Controller = TextEditingController();

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SafeArea(
              child: Text(
                "SIGNUP",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: size.width * 0.05),
              ),
            ),
            // SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/money_flat.svg",
              height: size.height * 0.35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.45,
                  child: RoundedInputField(
                    hintText: "First Name",
                    onChanged: (value) {},
                    icon: Icons.perm_identity,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Container(
                    width: size.width * 0.45,
                    child: RoundedInputField(
                        hintText: "Last Name", onChanged: (value) {})),
              ],
            ),

            Container(
              width: size.width * 0.92,
              child: RoundedInputField(
                textEditingController: emailController,
                hintText: "Email",
                icon: Icons.mail,
                onChanged: (value) {},
              ),
            ),
            Container(
              width: size.width * 0.92,
              child: RoundedPasswordField(
                onChanged: (value) {},
                textEditingController: password1Controller,
              ),
            ),
            Container(
              width: size.width * 0.92,
              child: RoundedInputField(
                icon: Icons.password,
                hintText: "Confirm Password",
                onChanged: (value) {},
                textEditingController: password2Controller,
              ),
            ),
            // RoundedButton(
            //     text: "SIGN UP",
            //     press: () async {
            //       if (_formKey.currentState!.validate() == true) {
            //         var uriPostSignupReq = Uri.parse(
            //             'https://f656139cf15c.ngrok.io/rest-auth/registration/');
            //         Map<String, String> postSignupReq = {
            //           "email": emailController.text,
            //           "password1": password1Controller.text,
            //           "password2": password2Controller.text,
            //         };
            //         print(emailController.text);
            //         print(password1Controller.text);
            //         print(password2Controller.text);
            //         print(postSignupReq);
            //         var postSignupBodyJson = json.encode(postSignupReq);
            //         print(postSignupBodyJson);
            //         // http.Response responseSignupPost = await http.post(
            //         //     uriPostSignupReq,
            //         //     body: postSignupBodyJson,
            //         //     headers: {"content-type": "application/json"});
            //         // print(responseSignupPost);
            //       }
            //     }),
            SizedBox(height: size.height * 0.03),
            ElevatedButton(
                onPressed: () {},
                child: Text("SIGN UP"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF009144)))),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.pushReplacementNamed(context, '/loginScreen');
              },
              login: false,
            ),
          ],
        ),
      ),
    ));
  }
}

//https://f656139cf15c.ngrok.io/rest-auth/registration/
