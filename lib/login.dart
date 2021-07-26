import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'validator.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode passFocusNode = FocusNode();

  bool isValid(String value, String regexSource) {
    try {
      final regex = RegExp(regexSource);
      final matches = regex.allMatches(value);
      for (Match match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }

  void emailNode() async {
    String regexSource = "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-]+\$)";

    bool valid = isValid(emailController.text, regexSource);
    if (valid) {
      emailFocusNode.unfocus();
    } else {
      emailFocusNode.requestFocus();
    }
  }

  void phoneNode() async {
    String regexSource = "^[0-9]{8}\$";

    bool valid = isValid(phoneController.text, regexSource);
    if (valid) {
      phoneFocusNode.unfocus();
    } else {
      phoneFocusNode.requestFocus();
    }
  }

  void passNode() async {
    String regexSource =
        "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}\$";

    bool valid = isValid(passController.text, regexSource);
    if (valid) {
      passFocusNode.unfocus();
    } else {
      passFocusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    // var deviceData = MediaQuery.of(context).padding.vertical;
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: screenSize.height * 0.175,
            horizontal: screenSize.width * 0.1),

        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage(''),
        //     ),
        //   ),

        decoration: BoxDecoration(
          gradient: SweepGradient(
            colors: [Color(0xff1de9b6), Color(0xff00e676), Color(0xffe8f5e9)],
            stops: [0.1, 0.6, 0.9],
            startAngle: 0.9,
            endAngle: 1.3,
          ),
        ),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/usdt.png'),
                radius: 20.0,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Text(
                'Welcome!',
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Text(
                'Please login with your credentials',
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'to continue!',
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          icon: Icon(
                            Icons.email,
                          ),
                          labelText: 'Email address'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      autocorrect: false,
                      inputFormatters: [
                        ValidatorInputFormatter(
                            editingValidator: EmailEditingRegexValidator())
                      ],
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      focusNode: emailFocusNode,
                      onEditingComplete: emailNode,
                    ),
                    // SizedBox(height: screenSize.height * 0.03,),
                    TextFormField(
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          icon: Icon(
                            Icons.phone,
                          ),
                          labelText: 'Phone number'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      autocorrect: false,
                      inputFormatters: [
                        ValidatorInputFormatter(
                            editingValidator:
                                PhoneNumberEditingRegexValidator()),
                      ],
                      controller: phoneController,
                      focusNode: phoneFocusNode,
                      onEditingComplete: phoneNode,
                    ),
                    // SizedBox(height: screenSize.height * 0.03,),
                    TextFormField(
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          icon: Icon(
                            Icons.lock,
                          ),
                          labelText: 'Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      obscureText: true,
                      autocorrect: false,
                      inputFormatters: [
                        ValidatorInputFormatter(
                            editingValidator: PasswordEditingRegexValidator()),
                      ],
                      keyboardType: TextInputType.visiblePassword,
                      controller: passController,
                      focusNode: passFocusNode,
                      onEditingComplete: passNode,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1.0,
              ),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forget password?',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              Center(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/signup',
                        );
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              // TextButton(
              //     onPressed: () {
              //       Navigator.pushReplacementNamed(context, '/trial',);
              //     },
              //     child: Text('Press me'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailEditingRegexValidator extends RegexValidator {
  EmailEditingRegexValidator()
      : super(
            regexSource:
                "^[a-zA-Z0-9_.+-]*(@([a-zA-Z0-9-]*(\\.[a-zA-Z0-9-]*)?)?)?\$");
}

class PhoneNumberEditingRegexValidator extends RegexValidator {
  PhoneNumberEditingRegexValidator() : super(regexSource: "^[0-9]{8}\$");
}

class PasswordEditingRegexValidator extends RegexValidator {
  PasswordEditingRegexValidator()
      : super(
            regexSource:
                "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}\$");
}
