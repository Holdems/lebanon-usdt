abstract class Request {
  final int id;
  final String username;
  final int amount;
  final double rate;
  final int totalPrice;
  final String type;

  Request(this.id,this.username, this.amount, this.rate, this.totalPrice, this.type);

  //Getters
  int getID() {
    return id;
  }

  String getUsername(){
    return username;
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

  String toStringType();

  @override
  String toString() {
    return 'Request{id: $id, username: $username, amount: $amount, rate: $rate, totalPrice: $totalPrice, type: $type}';
  }
}