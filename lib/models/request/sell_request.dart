import 'request.dart';

class SellRequest extends Request {
  SellRequest(int id, String username, int amount, double rate, int totalPrice, {type = "SR"})
      : super(id, username, amount, rate, totalPrice, type);

  @override
  String toStringType() {
    return "Sell";
  }
}