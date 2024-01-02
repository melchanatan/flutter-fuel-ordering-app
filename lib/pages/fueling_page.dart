import 'package:flutter/material.dart';
import 'package:fuel_ordering_tablet/constants/colors.dart';
import 'package:fuel_ordering_tablet/models/user_cart.dart';
import 'package:fuel_ordering_tablet/utils/widget.dart';
import 'package:marquee/marquee.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Fueling extends StatefulWidget {
  final UserCart userCart;
  const Fueling({super.key, required this.userCart});

  @override
  State<Fueling> createState() => _FuelingState();
}

class _FuelingState extends State<Fueling> {
  @override
  Widget build(BuildContext context) {
    final bLEProvider = Provider.of<BLEProvider>(context, listen: true);

    void reset() {
      var command = 'C';
      bLEProvider.sendCommand(command);
      Navigator.popUntil(context, ModalRoute.withName("/fuelSelect"));
    }

    return Material(
      child: Container(
        decoration: const BoxDecoration(
            gradient: AppColor.backgroundGradient,
            image: DecorationImage(
                image: AssetImage("lib/images/line-graphic.png"),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Stack(alignment: Alignment.topLeft, children: [
            // go next button
            Positioned(
              left: -40,
              top: -40,
              child: Container(
                width: 150,
                height: 150,
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
                  padding: const EdgeInsets.all(0),
                  iconSize: 90,
                  onPressed: reset,
                  icon: const Icon(
                    Icons.close,
                    color: AppColor.primaryBlue,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // fuel type heading
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.userCart.getFuel()!.name} ${widget.userCart.getFuel()!.quality}",
                        style: const TextStyle(
                            fontFamily: "KrungThep",
                            height: .9,
                            fontSize: 100,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      Text(
                        widget.userCart.getPrice()!,
                        style: const TextStyle(
                            fontFamily: "KrungThep",
                            height: .8,
                            fontSize: 100,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 3,
                    height: 0,
                    color: Colors.white,
                  ),
                  Expanded(
                      child: Row(
                    children: [
                      Flexible(
                          child: Center(
                        child: Transform.scale(
                          scale: 1.4,
                          child: SizedBox(
                            height: 1000,
                            width: 1000,
                            child: Lottie.asset('lib/images/tank-fueling.json'),
                          ),
                        ),
                      )),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // payment method
                                  Container(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          80,
                                      padding: const EdgeInsets.only(
                                          left: 40, top: 10, bottom: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              const BorderRadius.horizontal(
                                                  left: Radius.circular(20)),
                                          gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              stops: const [
                                                -.043,
                                                0.45,
                                                1.06,
                                              ],
                                              colors: [
                                                Colors.white,
                                                Colors.white.withOpacity(.47),
                                                Colors.white.withOpacity(.6)
                                              ])),
                                      child: Row(children: [
                                        Image.asset(
                                          widget.userCart
                                              .getPaymentMethod()!
                                              .imagePath,
                                          width: 100,
                                          height: 100,
                                          color: Colors.grey[800],
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Text(
                                            widget.userCart
                                                .getPaymentMethod()!
                                                .name,
                                            style: TextStyle(
                                              height: 1.3,
                                              fontSize: 35,
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "PlexSans",
                                            ))
                                      ])),

                                  // want receipt display
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            200,
                                    padding: const EdgeInsets.only(
                                        left: 40, top: 20, bottom: 20),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                                left: Radius.circular(20)),
                                        gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            stops: const [
                                              -.043,
                                              1.06,
                                            ],
                                            colors: [
                                              widget.userCart.getWantReceipt()
                                                  ? Colors.lightGreen.shade200
                                                  : Colors.red.shade200,
                                              Colors.white.withOpacity(.6)
                                            ])),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            widget.userCart.getWantReceipt()
                                                ? Icons.done
                                                : Icons.close,
                                            size: 50,
                                            color: Colors.grey[800],
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          Text("รับใบกำกับภาษี",
                                              style: TextStyle(
                                                height: 1.3,
                                                fontSize: 35,
                                                color: Colors.grey[800],
                                                fontWeight: FontWeight.normal,
                                                fontFamily: "PlexSans",
                                              ))
                                        ]),
                                  ),

                                  // want invoice display
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            200,
                                    padding: const EdgeInsets.only(
                                        left: 40, top: 20, bottom: 20),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                                left: Radius.circular(20)),
                                        gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            stops: const [
                                              -.043,
                                              1.06,
                                            ],
                                            colors: [
                                              widget.userCart.getWantInvoice()
                                                  ? Colors.lightGreen.shade200
                                                  : Colors.red.shade200,
                                              Colors.white.withOpacity(.6)
                                            ])),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            widget.userCart.getWantInvoice()
                                                ? Icons.done
                                                : Icons.close,
                                            size: 50,
                                            color: Colors.grey[800],
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          Text("รับใบเสร็จ",
                                              style: TextStyle(
                                                height: 1.3,
                                                fontSize: 35,
                                                color: Colors.grey[800],
                                                fontWeight: FontWeight.normal,
                                                fontFamily: "PlexSans",
                                              ))
                                        ]),
                                  ),
                                ]),
                          ),
                          CustomPaint(
                            painter: BoxShadowPainter(),
                            child: Opacity(
                              opacity: .1,
                              child: ClipPath(
                                clipper: SkewCut(),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: MediaQuery.of(context).size.height,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
                  Container(
                    height: 100,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      gradient: AppColor.glassGradientLight,
                    ),
                    child: Container(
                      child: Marquee(
                        text: '     กรุณาอย่าเคลื่อนรถ ขณะให้บริการ    ⚠️',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontFamily: "PlexSans",
                        ),
                        velocity: 50.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class BoxShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    path.lineTo(60, size.height + 3);
    path.lineTo(60, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 6.0, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class SkewCut extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height);
    path.lineTo(60, size.height);
    path.close();
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(SkewCut oldClipper) => false;
}
