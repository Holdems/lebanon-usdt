import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

//onDone will transform number to %
class _MyAppState extends State<MyApp> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController totalPriceController = TextEditingController();

  double calculateRatio(double totalPrice, double amount) {
    if (amount == 0 && (totalPrice == 0 || totalPrice == 1)) {
      return 0;
    }
    return totalPrice / amount;
  }

  double calculatePrice(double amount, double ratio) {
    return amount * ratio;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Amount TextField
              TextField(
                onChanged: (text) {
                  if (amountController.text.isEmpty) {
                    rateController.text = "";
                    totalPriceController.text = "";
                  }
                  rateController.text = calculateRatio(
                          double.parse(totalPriceController.text),
                          double.parse(amountController.text))
                      .toString();
                },
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "e.g: 100-5000",
                    border: OutlineInputBorder(),
                    labelText: "Amount in USDT"),
              ),

              //Rate TextField
              TextField(
                onChanged: (text) {
                  if (rateController.text.isEmpty) {
                    totalPriceController.text = "";
                  }
                  totalPriceController.text = calculatePrice(
                          double.parse(amountController.text),
                          double.parse(rateController.text))
                      .toString();
                },
                controller: rateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "e.g: 1.05 (5%)",
                    border: OutlineInputBorder(),
                    labelText: "Rate"),
              ),

              //TotalPrice TextField
              TextField(
                onChanged: (text) {
                  if (totalPriceController.text.isEmpty) {
                    rateController.text = "";
                  }
                  rateController.text = calculateRatio(
                          double.parse(totalPriceController.text),
                          double.parse(amountController.text))
                      .toString();
                },
                controller: totalPriceController,
                keyboardType: TextInputType.numberWithOptions(
                    signed: false, decimal: true),
                decoration: InputDecoration(
                    hintText: "e.g: 400",
                    border: OutlineInputBorder(),
                    labelText: "Total Price"),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text('Submit'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[300]),
                      foregroundColor:
                          MaterialStateProperty.all((Colors.white))))
            ],
          ),
        ),
      ),
    );
  }
}
