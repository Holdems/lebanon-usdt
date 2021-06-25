import 'request.dart';

class SellRequest extends Request {
  SellRequest(int id, int amount, double rate, int totalPrice, {type = "SR"})
      : super(id, amount, rate, totalPrice, type);
}