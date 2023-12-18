import 'package:flutter/material.dart';
import 'package:fuel_ordering_tablet/models/fuel.dart';

class Order {
  // all fuel type
  List<Fuel> fuels = [
    Fuel(
        id: 3,
        name: "Gasohol",
        subname: "เบนซินเเก็สโซฮอล์",
        quality: "95",
        color: Colors.orange),
    Fuel(
        id: 2,
        name: "Gasohol",
        subname: "เบนซินเเก็สโซฮอล์",
        quality: "91",
        color: Colors.green),
    Fuel(
        id: 4,
        name: "Diesel",
        subname: "ดีเซล",
        quality: "B7",
        color: Colors.blue),
    Fuel(
        id: 1,
        name: "เบนซิน",
        subname: "เเก็สโซฮอล์",
        quality: "E20",
        color: Colors.purple)
  ];

  // get all fuels
  List<Fuel> getFuels() {
    return fuels;
  }

  // all price
  List<String> prices = ["1000 บาท", "500 บาท", "200 บาท", "100 บาท"];

  // get all prices
  List<String> getPrices() {
    return prices;
  }

  // all payment type
  List<PaymentMethod> methods = [
    PaymentMethod(name: "พร้อมเพย์", imagePath: "lib/images/promptpay.png"),
    PaymentMethod(name: "บัตรเครดิต", imagePath: "lib/images/credit-card.png"),
    PaymentMethod(name: "บัตรเดบิท", imagePath: "lib/images/credit-card.png"),
    PaymentMethod(name: "เงินสด", imagePath: "lib/images/cash.png"),
    PaymentMethod(name: "Fleet Cart", imagePath: "lib/images/fleet-card.png"),
    PaymentMethod(name: "Blue Card", imagePath: "lib/images/blue-card.png")
  ];

  List<PaymentMethod> getMethods() {
    return methods;
  }
}

class PaymentMethod {
  final String name;
  final String imagePath;

  PaymentMethod({required this.name, required this.imagePath});
}
