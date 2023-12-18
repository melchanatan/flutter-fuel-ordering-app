import 'package:flutter/material.dart';
import 'package:fuel_ordering_tablet/components/ble_button.dart';
import 'package:fuel_ordering_tablet/components/glass_button.dart';
import 'package:fuel_ordering_tablet/constants/colors.dart';
import 'package:fuel_ordering_tablet/models/order.dart';
import 'package:fuel_ordering_tablet/models/user_cart.dart';

class PaymentSelect extends StatefulWidget {
  final UserCart userCart;
  const PaymentSelect({super.key, required this.userCart});

  @override
  State<PaymentSelect> createState() => _PaymentSelectState();
}

class _PaymentSelectState extends State<PaymentSelect> {
  @override
  void initState() {
    super.initState();
    // This function will be called when the widget is rendered.
    wantReceipt = widget.userCart.wantReceipt;
    wantInvoice = widget.userCart.wantInvoice;
  }

  Order order = Order();

  bool wantReceipt = false;
  bool wantInvoice = false;

  // toggle want receipt checkbox
  void toggleWantInvoice(bool? value) {
    setState(() {
      wantInvoice = value!;
      widget.userCart.setWantInvoice(wantInvoice);
    });
  }

  // toggle want receipt checkbox

  void toggleWantReceipt(bool? value) {
    setState(() {
      wantReceipt = value!;
      widget.userCart.setWantReceipt(wantReceipt);
    });
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
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Positioned(top: 55, right: 120, child: const BleButton()),

                // go back button
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      left: 128.0, right: 128, top: 64, bottom: 32),
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
                      const SizedBox(height: 12),

                      // fuel type button grid
                      Expanded(
                        child: GridView.builder(
                            itemCount: 6,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 3.5,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 40),
                            itemBuilder: (context, index) {
                              PaymentMethod paymentMethod =
                                  order.getMethods()[index];

                              void handleTap() {
                                Navigator.pushNamed(context, "/summary");
                                widget.userCart.setPaymentMethod(paymentMethod);
                              }

                              return GlassButton(
                                text: paymentMethod.name,
                                imagePath: paymentMethod.imagePath,
                                onTap: handleTap,
                              );
                            }),
                      ),
                      // const SizedBox(height: 24),
                      Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Transform.scale(
                                scale: 2,
                                child: Checkbox(
                                  value: wantReceipt,
                                  onChanged: toggleWantReceipt,
                                ),
                              ),
                              const Text("รับใบเสร็จ",
                                  style: TextStyle(
                                      height: 1.8,
                                      color: Colors.white,
                                      fontFamily: "PlexSans",
                                      fontSize: 35))
                            ],
                          ),
                          const SizedBox(width: 80),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Transform.scale(
                                scale: 2,
                                child: Checkbox(
                                  value: wantInvoice,
                                  onChanged: toggleWantInvoice,
                                ),
                              ),
                              const Text("รับใบกำกับภาษี",
                                  style: TextStyle(
                                      height: 1.8,
                                      color: Colors.white,
                                      fontFamily: "PlexSans",
                                      fontSize: 35))
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}
