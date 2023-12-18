import 'package:flutter/material.dart';
import 'package:fuel_ordering_tablet/components/gradient_text.dart';
import 'package:fuel_ordering_tablet/constants/colors.dart';
import 'package:fuel_ordering_tablet/models/user_cart.dart';

class Summary extends StatefulWidget {
  final UserCart userCart;
  const Summary({super.key, required this.userCart});

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          decoration: const BoxDecoration(
              gradient: AppColor.backgroundGradient,
              image: DecorationImage(
                  image: AssetImage("lib/images/line-graphic.png"),
                  fit: BoxFit.cover)),
          child: SafeArea(
            child: Stack(alignment: Alignment.centerLeft, children: [
              // go next button
              Positioned(
                right: -90,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(.1),
                          spreadRadius: 5)
                    ],
                  ),
                  child: IconButton(
                    padding: const EdgeInsets.only(right: 40),
                    iconSize: 90,
                    onPressed: () => {Navigator.pushNamed(context, '/buffer')},
                    icon: const Icon(
                      Icons.check_sharp,
                      color: AppColor.darkenGreen,
                    ),
                  ),
                ),
              ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'กรุณาคอนเฟิร์มออเดอร์',
                      style: TextStyle(
                          fontSize: 48,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontFamily: "PlexSans"),
                    ),
                    const SizedBox(
                      height: 60,
                    ),

                    // fuel type heading
                    Transform.translate(
                      offset: const Offset(0, 16),
                      child: GradientText(
                        widget.userCart.fuel!.name != ""
                            ? "${widget.userCart.getFuel()!.name} ${widget.userCart.getFuel()!.quality}"
                            : "",
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: const [
                              -.043,
                              0.45,
                              .6,
                            ],
                            colors: [
                              widget.userCart.getFuel()!.color.lighten(.05),
                              widget.userCart.getFuel()!.color.lighten(.3),
                              widget.userCart.getFuel()!.color.lighten(1)
                            ]),
                        style: TextStyle(
                            fontFamily: "KrungThep",
                            shadows: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(1),
                                  blurRadius: 5,
                                  offset: Offset(-3, 1))
                            ],
                            height: .9,
                            fontSize: 200,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -20),
                      child: GradientText(
                        widget.userCart.getPrice()!,
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: const [
                              -.043,
                              0.45,
                              1.06,
                            ],
                            colors: [
                              widget.userCart.getFuel()!.color.lighten(.05),
                              widget.userCart.getFuel()!.color.lighten(.3),
                              widget.userCart.getFuel()!.color.lighten(1)
                            ]),
                        style: const TextStyle(
                            fontFamily: "KrungThep",
                            shadows: [
                              BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(1, 2))
                            ],
                            height: 1,
                            fontSize: 150,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("ชำระด้วย",
                                style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.white,
                                    fontFamily: "PlexSans")),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  )),
                              child: Row(
                                children: [
                                  Text(
                                    widget.userCart.getPaymentMethod()!.name,
                                    style: const TextStyle(
                                      fontFamily: "KrungThep",
                                      fontSize: 35,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    widget.userCart
                                        .getPaymentMethod()!
                                        .imagePath,
                                    width: 80,
                                    height: 80,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    )
                    // price heading
                  ],
                ),
              ),
            ]),
          )),
    );
  }
}

extension ColorBrightness on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
