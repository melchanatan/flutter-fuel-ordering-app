import 'package:flutter/material.dart';
import 'package:fuel_ordering_tablet/components/ble_button.dart';
import 'package:fuel_ordering_tablet/components/fuel_type_button.dart';
import 'package:fuel_ordering_tablet/constants/colors.dart';
import 'package:fuel_ordering_tablet/models/fuel.dart';
import 'package:fuel_ordering_tablet/models/order.dart';
import 'package:fuel_ordering_tablet/models/user_cart.dart';

import 'dart:developer';

class FuelSelect extends StatefulWidget {
  final UserCart userCart;
  const FuelSelect({super.key, required this.userCart});

  @override
  State<FuelSelect> createState() => _FuelSelectState();
}

class _FuelSelectState extends State<FuelSelect> {
  @override
  Widget build(BuildContext context) {
    Order order = Order();

    // handle tab
    void handleTap(Fuel fuel) {
      // go to price select page
      Navigator.pushNamed(context, '/priceSelect');

      // set selected fuel
      widget.userCart.setFuel(fuel);
    }

    return Material(
      child: Container(
        decoration: const BoxDecoration(
            gradient: AppColor.backgroundGradient,
            image: DecorationImage(
                image: AssetImage("lib/images/line-graphic.png"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.only(left: 128.0, right: 128, top: 64),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              const BleButton(),
              Column(
                children: [
                  // heading text
                  const Text(
                    "เลือกประเภทน้ำมัน",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontFamily: "PlexSans",
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 48),

                  // fuel type button grid
                  Expanded(
                    child: GridView.builder(
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 3,
                                crossAxisCount: 2,
                                mainAxisSpacing: 40,
                                crossAxisSpacing: 60),
                        itemBuilder: (context, index) {
                          Fuel fuel = order.getFuels()[index];
                          return FuelTypeButton(fuel: fuel, onTap: handleTap);
                        }),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
