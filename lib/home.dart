import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lusdt/validator.dart';

class Home extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstController = TextEditingController();
  final TextEditingController lastController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final FocusNode firstFocusNode = FocusNode();
  final FocusNode lastFocusNode = FocusNode();
  final FocusNode userFocusNode = FocusNode();
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

  void firstNode() async {
    if (firstController.text.isNotEmpty) {
      firstFocusNode.unfocus();
    } else {
      // FocusScope.of(context).requestFocus(firstFocusNode);
      firstFocusNode.requestFocus();
    }
  }

  void lastNode() async {
    if (lastController.text.isNotEmpty) {
      lastFocusNode.unfocus();
    } else {
      lastFocusNode.requestFocus();
    }
  }

  void userNode() async {
    //
    if (userController.text.isNotEmpty) {
      userFocusNode.unfocus();
    } else {
      userFocusNode.requestFocus();
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
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: screenSize.height * 0.12,
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
                'Please create an account',
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
                          Icons.person,
                        ),
                        labelText: 'First name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      autocorrect: false,
                      inputFormatters: [
                        ValidatorInputFormatter(
                            editingValidator: FullNameEditingRegexValidator())
                      ],
                      keyboardType: TextInputType.name,
                      focusNode: firstFocusNode,
                      controller: firstController,
                      onEditingComplete: firstNode,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        icon: Icon(
                          Icons.person,
                        ),
                        labelText: 'Last name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      autocorrect: false,
                      inputFormatters: [
                        ValidatorInputFormatter(
                            editingValidator: FullNameEditingRegexValidator())
                      ],
                      keyboardType: TextInputType.name,
                      controller: lastController,
                      focusNode: lastFocusNode,
                      onEditingComplete: lastNode,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        icon: Icon(
                          Icons.account_circle,
                        ),
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      autocorrect: false,
                      inputFormatters: [
                        ValidatorInputFormatter(
                            editingValidator: UsernameEditingRegexValidator()),
                      ],
                      keyboardType: TextInputType.text,
                      controller: userController,
                      focusNode: userFocusNode,
                      onEditingComplete: userNode,
                    ),
                    // SizedBox(height: screenSize.height * 0.03,),
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
                      keyboardType: TextInputType.number,
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
                      height: screenSize.height * 0.02,
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
                          'Sign up',
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
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Row(
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/',
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FullNameEditingRegexValidator extends RegexValidator {
  FullNameEditingRegexValidator() : super(regexSource: "^[A-Za-z ]*\$");
}

class UsernameEditingRegexValidator extends RegexValidator {
  UsernameEditingRegexValidator() : super(regexSource: "^[A-Za-z0-9_ ]*\$");
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
