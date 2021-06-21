import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lebanon_usdt/validator.dart';

bool firstSubmit = false;
bool priceGotDeleted = false;
bool isPositiveRate = true;

AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

class MakeRequestScreen extends StatefulWidget {
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

  calibrateRateOnEditingComplete() {
    if (amountController.text.isNotEmpty &&
        totalPriceController.text.isNotEmpty && rateController.text.isNotEmpty) {
      if (calculateRate(double.parse(totalPriceController.text.toString()),
              double.parse(amountController.text.toString())) !=
          double.parse(rateController.text.toString())) {
        rateController.text = calculateRate(
                double.parse(totalPriceController.text.toString()),
                double.parse(amountController.text.toString()))
            .toStringAsFixed(2);
        FocusScope.of(context).unfocus();
      }
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  calibrateRateOnTap() {
    if (amountController.text.isNotEmpty &&
        totalPriceController.text.isNotEmpty && rateController.text.isNotEmpty) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              TextFormField(
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
                        onPressed: () async {
                          setState(() {
                            // Here we're changing the icon.
                            isPositiveRate = !isPositiveRate;
                            rateController.text = "";
                            // _focusNode.unfocus();
                            if (!_focusNode.hasFocus) {
                              _focusNode.canRequestFocus = false;
                            }
                          });
                        }),
                    icon: Icon(Icons.rate_review),
                    hintText: "e.g: 3, -1.5",
                    border: OutlineInputBorder(),
                    labelText: "Rate"),
              ),

              //TotalPrice
              TextFormField(
                enabled: amountController.text.isNotEmpty ? true : false,
                validator: (value) {
                  if (totalPriceController.text.isNotEmpty &&
                      firstSubmit &&
                      double.parse(totalPriceController.text.toString()) >
                          (2 * double.parse(amountController.text))) {
                    return "Keep the rate between\n-99.99 and +99.99";
                  }
                  if (priceGotDeleted) {
                    priceGotDeleted = false;
                    return "Keep the rate between\n-99.99 and +99.99";
                  }
                  if (value == null || value.isEmpty) {
                    return "Please enter some text";
                  }
                  if (double.parse(totalPriceController.text.toString()) >
                      (2 * double.parse(amountController.text))) {
                    return "Keep the rate between\n-99.99 and +99.99";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  ValidatorInputFormatter(
                      editingValidator:
                          // amountController.text.isEmpty ?
                          TotalPriceEditingRegexValidator())
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
                },
                onTap: () {
                  calibrateRateOnTap();
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.monetization_on),
                    suffixIcon: Icon(Icons.shopping_bag),
                    hintText: "e.g: 400",
                    border: OutlineInputBorder(),
                    labelText: "Total Price"),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    firstSubmit = true;
                    if (_formKey.currentState!.validate()) {
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
