import 'package:flutter/material.dart';
import 'package:fuel_ordering_tablet/components/glass_button.dart';
import 'package:fuel_ordering_tablet/components/select_wheel.dart';
import 'package:fuel_ordering_tablet/constants/colors.dart';
import 'package:fuel_ordering_tablet/models/user_cart.dart';
import 'package:selector_wheel/selector_wheel.dart';

class CustomPriceSelect extends StatefulWidget {
  UserCart userCart;

  CustomPriceSelect({super.key, required this.userCart});

  @override
  State<CustomPriceSelect> createState() => _CustomPriceSelectState();
}

class _CustomPriceSelectState extends State<CustomPriceSelect> {
  List<String> fourDigitPrice = ["0", "0", "0", "0"];

  // set state four digit price
  void setFourDigitPrice(String number, int index) {
    setState(() {
      fourDigitPrice[index] = number;
    });
  }

  // go back
  void goBack() {
    Navigator.pop(context);
  }

  void handleConfirm() {
    widget.userCart.setPrice(
        fourDigitPrice.join().replaceAll(new RegExp(r'^0+(?=.)'), '') + " บาท");
    Navigator.pushNamed(context, "/paymentSelect");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            decoration: const BoxDecoration(
                gradient: AppColor.backgroundGradient,
                image: DecorationImage(
                    image: AssetImage("lib/images/line-graphic.png"),
                    fit: BoxFit.cover)),
            child: Stack(alignment: Alignment.centerLeft, children: [
              // confirm button
              Positioned(
                  bottom: 50,
                  right: 50,
                  child: SizedBox(
                      width: 300,
                      height: 100,
                      child: GlassButton(
                        text: "ตกลง",
                        imagePath: "lib/images/check-icon.png",
                        imageSize: 50,
                        onTap: handleConfirm,
                      ))),
              Positioned(
                left: MediaQuery.of(context).size.width / 2 - 150,
                top: 80,
                child: const Text(
                  "เลือกประเภทน้ำมัน",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontFamily: "PlexSans",
                      fontWeight: FontWeight.normal),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, 13),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  decoration:
                      BoxDecoration(gradient: AppColor.glassGradientLight),
                ),
              ),

              // go back button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: IconButton(
                  onPressed: goBack,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 100),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  // custom price selector
                  SelectWheel(
                    onValueChanged: setFourDigitPrice,
                    index: 0,
                  ),
                  SelectWheel(
                    onValueChanged: setFourDigitPrice,
                    index: 1,
                  ),
                  SelectWheel(
                    onValueChanged: setFourDigitPrice,
                    index: 2,
                  ),
                  SelectWheel(
                    onValueChanged: setFourDigitPrice,
                    index: 3,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Transform.translate(
                    offset: const Offset(0, 13),
                    child: Text(
                      "บาท",
                      style: TextStyle(
                          fontSize: 82,
                          fontFamily: "PlexSans",
                          color: Colors.white),
                    ),
                  )
                ]),
              )
            ])));
  }
}
