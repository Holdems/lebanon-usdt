import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lebanon_usdt/colors.dart';
import 'package:lebanon_usdt/models/request/buy_request.dart';
import 'package:lebanon_usdt/services/api_services/post_sell_request_api.dart';
import 'package:lebanon_usdt/services/api_services/put_buy_request_api.dart';
import 'package:lebanon_usdt/validator.dart';
import 'package:http/http.dart' as http;

String responseMessage = "";
bool priceGotDeleted = false;
bool isPositiveRate = true;
bool isEnabled = false;
AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

class MakeRequestScreen extends StatefulWidget {
  final String title;
  const MakeRequestScreen({Key? key, required this.title}) : super(key: key);
  @override
  _MakeRequestScreenState createState() => _MakeRequestScreenState();
}

class _MakeRequestScreenState extends State<MakeRequestScreen> {
  FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController amountController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController totalPriceController = TextEditingController();

  double calculateRate(double totalPrice, double amount) {
    if (amount == 0 && (totalPrice == 0 || totalPrice == 1)) {
      return 0;
    }

    if (totalPrice < amount) {
      setState(() {
        isPositiveRate = false;
      });
    } else {
      setState(() {
        isPositiveRate = true;
      });
    }
    double calculatedRate = ((totalPrice / amount) * 100 - 100).abs();
    if (calculatedRate >= 99.99) {
      return 99.99;
    } else
      return calculatedRate;
  }

  double calculatePrice(double amount, double rate) {
    double answer;
    if (isPositiveRate) {
      answer = 1 + rate / 100;
    } else {
      answer = 1 - rate / 100;
    }
    return amount * answer;
  }

  changeSubmitButtonColor() {
    if (totalPriceController.text.isNotEmpty &&
        double.parse(amountController.text) >= 10 &&
        rateController.text.isNotEmpty) {
      setState(() {
        isEnabled = true;
      });
    } else {
      setState(() {
        isEnabled = false;
      });
    }
  }

  calibrateRateOnEditingComplete() {
    if (amountController.text.isNotEmpty &&
        totalPriceController.text.isNotEmpty &&
        rateController.text.isNotEmpty) {
      if (calculateRate(double.parse(totalPriceController.text.toString()),
              double.parse(amountController.text.toString())) !=
          double.parse(rateController.text.toString())) {
        rateController.text = calculateRate(
                double.parse(totalPriceController.text.toString()),
                double.parse(amountController.text.toString()))
            .toStringAsFixed(2);
        FocusScope.of(context).unfocus();
      }
    }
    FocusScope.of(context).unfocus();
  }

  calibrateRateOnTap() {
    if (amountController.text.isNotEmpty &&
        totalPriceController.text.isNotEmpty &&
        rateController.text.isNotEmpty) {
      if (calculateRate(double.parse(totalPriceController.text.toString()),
              double.parse(amountController.text.toString())) !=
          double.parse(rateController.text.toString())) {
        rateController.text = calculateRate(
                double.parse(totalPriceController.text.toString()),
                double.parse(amountController.text.toString()))
            .toStringAsFixed(2);
      }
    }
  }

  void onPageEnter() {
    priceGotDeleted = false;
    isPositiveRate = true;
    isEnabled = false;
    autoValidateMode = AutovalidateMode.disabled;
  }

  @override
  void initState() {
    onPageEnter();
    super.initState();
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  final style = TextStyle(color: Colors.grey);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: secondaryColor,
        title: (widget.title == "buy")
            ? Text("Buy", style: TextStyle(color: Colors.grey[800]))
            : Text(
                "Sell",
                style: style,
              ),
      ),
      body: Container(
        margin: EdgeInsets.all(50),
        child: Form(
          autovalidateMode: autoValidateMode,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Amount
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty || int.parse(value) < 10) {
                    return "Amount should be between\n10 and 9,999,999";
                  }
                  return null;
                },
                onChanged: (text) {
                  setState(() {});
                  if (amountController.text.isEmpty) {
                    rateController.text = "";
                    totalPriceController.text = "";
                  }
                  if (rateController.text.isNotEmpty) {
                    totalPriceController.text = calculatePrice(
                            double.parse(amountController.text),
                            double.parse(rateController.text))
                        .round()
                        .toString();
                  }
                  changeSubmitButtonColor();
                },
                onFieldSubmitted: (context) {
                  calibrateRateOnEditingComplete();
                },
                onTap: () {
                  calibrateRateOnTap();
                },
                controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  ValidatorInputFormatter(
                      editingValidator: AmountEditingRegexValidator())
                ],
                decoration: InputDecoration(
                    icon: Icon(Icons.sell),
                    hintText: "e.g: 100-5000",
                    border: OutlineInputBorder(),
                    labelText: "Amount in USDT"),
              ),
              //Rate
              Theme(
                data: new ThemeData(
                  primaryColor: Colors.redAccent,
                  primaryColorDark: Colors.red,
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        (double.parse(rateController.text) > 99.99)) {
                      return "Please enter a rate between\n-99.99% and +99.99%";
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    calibrateRateOnEditingComplete();
                  },
                  onChanged: (text) {
                    if (rateController.text.isEmpty) {
                      totalPriceController.text = "";
                    }
                    if (amountController.text.isNotEmpty &&
                        rateController.text.isNotEmpty) {
                      totalPriceController.text = calculatePrice(
                              double.parse(amountController.text),
                              double.parse(rateController.text))
                          .round()
                          .toString();
                    }
                    changeSubmitButtonColor();
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    ValidatorInputFormatter(
                        editingValidator: DecimalNumberEditingRegexValidator())
                  ],
                  controller: rateController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                      suffixText: "%",
                      prefixIcon: IconButton(
                          icon: isPositiveRate
                              ? Icon(Icons.add)
                              : Icon(
                                  Icons.remove,
                                ),
                          onPressed: () {
                            setState(() {
                              // Here we're changing the icon.
                              isPositiveRate = !isPositiveRate;
                              rateController.text = "";
                              if (!_focusNode.hasFocus) {
                                _focusNode.canRequestFocus = false;
                              }
                            });
                            changeSubmitButtonColor();
                          }),
                      icon: Icon(Icons.rate_review),
                      hintText: "e.g: 3, -1.5",
                      border: OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      // focusedBorder: const OutlineInputBorder(
                      //   borderSide: const BorderSide(color: primaryColor,width: 2),
                      // ),
                      labelText: "Rate"),
                ),
              ),

              //TotalPrice
              TextFormField(
                enabled: amountController.text.isNotEmpty ? true : false,
                validator: (value) {
                  if (totalPriceController.text.isNotEmpty &&
                      double.parse(totalPriceController.text.toString()) >
                          (2 * double.parse(amountController.text))) {
                    autoValidateMode = AutovalidateMode.onUserInteraction;
                    return "Keep the rate between\n-99.99 and +99.99";
                  }
                  if (priceGotDeleted && totalPriceController.text.isEmpty) {
                    priceGotDeleted = false;
                    return "Keep the rate between\n-99.99 and +99.99";
                  }

                  if (value == null || value.isEmpty) {
                    return "Please enter some text";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  ValidatorInputFormatter(
                      editingValidator: TotalPriceEditingRegexValidator())
                ],
                controller: totalPriceController,
                onChanged: (text) {
                  if (totalPriceController.text.isNotEmpty &&
                      amountController.text.isNotEmpty) {
                    if (double.parse(totalPriceController.text.toString()) >=
                        2 * double.parse(amountController.text)) {
                      _formKey.currentState!.validate();
                      totalPriceController.text = "";
                      totalPriceController.selection =
                          TextSelection.fromPosition(TextPosition(
                              offset: totalPriceController.text.length));
                      priceGotDeleted = true;
                    }
                  }

                  if (totalPriceController.text.isEmpty) {
                    rateController.text = "";
                  }
                  if (totalPriceController.text.isNotEmpty &&
                      amountController.text.isNotEmpty) {
                    rateController.text = calculateRate(
                            double.parse(totalPriceController.text),
                            double.parse(amountController.text))
                        .toStringAsFixed(2);
                  }
                  changeSubmitButtonColor();
                },
                onTap: () {
                  calibrateRateOnTap();
                },

                decoration: InputDecoration(
                  focusColor: Colors.green,
                    fillColor: Colors.green,
                    hoverColor: Colors.green,
                    icon: Icon(Icons.monetization_on,color: primaryColor,),
                    suffixIcon: Icon(Icons.shopping_bag),
                    hintText: "e.g: 400",
                    border: OutlineInputBorder(),
                    labelText: "Total Price"),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: isEnabled
                          ? MaterialStateProperty.all(primaryColor)
                          : MaterialStateProperty.all(Colors.grey),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showLoaderDialog(context);
                      String user = "William";
                      int amount = int.parse(amountController.text);
                      double rate = isPositiveRate
                          ? double.parse(rateController.text)
                          : -double.parse(rateController.text);
                      int totalPrice = int.parse(totalPriceController.text);

                      print(widget.title);
                      if (widget.title == "sell") {
                        http.Response response =
                            await postSr(user, amount, rate, totalPrice);

                        if (response.statusCode == 201) {
                          Navigator.pop(context);
                          responseMessage = "Success!";
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              // action: SnackBarAction(
                              //   label: 'Action',
                              //   onPressed: () {
                              //     // Code to execute.
                              //   },
                              // ),
                              content: Text('$responseMessage'),
                              duration: const Duration(milliseconds: 1500),
                              width: 280.0, // Width of the SnackBar.
                              padding: const EdgeInsets.symmetric(
                                horizontal:
                                    8.0, // Inner padding for SnackBar content.
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )));

                        } else {}
                      } else if (widget.title == "buy") {
                        postBr(user, amount, rate, totalPrice);
                      }
                      print("success");
                    }
                    autoValidateMode = AutovalidateMode.onUserInteraction;
                  },
                  child: Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }
}

class DecimalNumberEditingRegexValidator extends RegexValidator {
  DecimalNumberEditingRegexValidator()
      : super(regexSource: "^\$|^(0|([1-9][0-9]{0,1}))(\\.[0-9]{0,2})?\$");
}

class AmountEditingRegexValidator extends RegexValidator {
  AmountEditingRegexValidator()
      //numbers from 10 to 9 999 999
      : super(regexSource: "^.{0}\$|^[1-9]\$|^[1-9][0-9]{1,6}\$");
}

class TotalPriceEditingRegexValidator extends RegexValidator {
  TotalPriceEditingRegexValidator()
      //numbers from 10 to 99 999 999
      : super(regexSource: "^.{0}\$|^[1-9]\$|^[1-9][0-9]{1,7}\$");
}

class DecimalNumberSubmitValidator implements StringValidator {
  @override
  bool isValid(String value) {
    try {
      final number = double.parse(value);
      return number > 0.0;
    } catch (e) {
      return false;
    }
  }
}
