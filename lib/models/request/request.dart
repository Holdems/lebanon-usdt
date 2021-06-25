abstract class Request {
  final int id;
  final int amount;
  final double rate;
  final int totalPrice;
  final String type;

  Request(this.id, this.amount, this.rate, this.totalPrice, this.type);

  //Getters
  int getID() {
    return id;
  }

  int getAmount() {
    return amount;
  }

  double getRate() {
    return rate;
  }

  int getTotalPrice() {
    return totalPrice;
  }

  String getType() {
    return type;
  }

  @override
  String toString() {
    return 'Request{id: $id, amount: $amount, rate: $rate, totalPrice: $totalPrice, type: $type}';
  }
}