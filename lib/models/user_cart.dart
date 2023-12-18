import 'package:fuel_ordering_tablet/models/fuel.dart';
import 'package:fuel_ordering_tablet/models/order.dart';

class UserCart {
  Fuel? fuel;
  String? price;
  PaymentMethod? paymentMethod;
  bool wantReceipt;
  bool wantInvoice;

  UserCart(
      {this.fuel,
      this.price = "0",
      this.paymentMethod,
      this.wantReceipt = false,
      this.wantInvoice = false});

  // get fuel
  Fuel? getFuel() {
    return fuel;
  }

  // get price
  String? getPrice() {
    return price;
  }

  // get payment method
  PaymentMethod? getPaymentMethod() {
    return paymentMethod;
  }

  // get want receipt
  bool getWantReceipt() {
    return wantReceipt;
  }

  // get want invoice
  bool getWantInvoice() {
    return wantInvoice;
  }

  // set fuel
  void setFuel(Fuel fuel) {
    this.fuel = fuel;
  }

  // set price
  void setPrice(String price) {
    this.price = price;
  }

  // set payment method
  void setPaymentMethod(PaymentMethod paymentMethod) {
    this.paymentMethod = paymentMethod;
  }

  // set want receipt
  void setWantReceipt(bool wantReceipt) {
    this.wantReceipt = wantReceipt;
  }

  // set want invoice
  void setWantInvoice(bool wantInvoice) {
    this.wantInvoice = wantInvoice;
  }
}
