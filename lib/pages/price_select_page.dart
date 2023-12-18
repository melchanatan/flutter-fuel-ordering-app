import 'package:flutter/material.dart';
import 'package:fuel_ordering_tablet/components/ble_button.dart';
import 'package:fuel_ordering_tablet/components/glass_button.dart';
import 'package:fuel_ordering_tablet/constants/colors.dart';
import 'package:fuel_ordering_tablet/models/order.dart';
import 'package:fuel_ordering_tablet/models/user_cart.dart';

class PriceSelect extends StatefulWidget {
  final UserCart userCart;
  const PriceSelect({super.key, required this.userCart});

  @override
  State<PriceSelect> createState() => _PriceSelectState();
}

class _PriceSelectState extends State<PriceSelect> {
  Order order = Order();

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
            Positioned(top: 55, right: 120, child: const BleButton()),

            // go back button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: IconButton(
                onPressed: () => {Navigator.pop(context)},
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 128.0, right: 128, top: 64, bottom: 98),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  const SizedBox(height: 24),

                  // fuel type button grid
                  Expanded(
                    child: GridView.builder(
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 3.5,
                                crossAxisCount: 2,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 40),
                        itemBuilder: (context, index) {
                          String price = order.getPrices()[index];

                          void handleTap() {
                            Navigator.pushNamed(context, "/paymentSelect");
                            widget.userCart.setPrice(price);
                          }

                          return GlassButton(
                            text: price,
                            onTap: handleTap,
                          );
                        }),
                  ),
                  SizedBox(
                    height: 140,
                    child: GlassButton(
                        text: "กรอกราคาเอง",
                        imagePath: "lib/images/create-icon.png",
                        onTap: () => {
                              Navigator.pushNamed(context, "/customPriceSelect")
                            }),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
