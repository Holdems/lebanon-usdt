import 'request.dart';

class BuyRequest extends Request {
  BuyRequest(int id, String username, int amount, double rate, int totalPrice, {type = "BR"})
      : super(id, username, amount, rate, totalPrice, type);

  @override
  String toStringType() {
    return "Buy";
  }
}