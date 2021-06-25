import 'request.dart';

class BuyRequest extends Request {
  BuyRequest(int id, int amount, double rate, int totalPrice, {type = "BR"})
      : super(id, amount, rate, totalPrice, type);
}