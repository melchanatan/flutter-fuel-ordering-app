import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fuel_ordering_tablet/constants/colors.dart';
import 'package:fuel_ordering_tablet/models/user_cart.dart';
import 'package:fuel_ordering_tablet/utils/widget.dart';
import 'package:provider/provider.dart';

class Buffer extends StatefulWidget {
  UserCart userCart;
  Buffer({super.key, required this.userCart});

  @override
  State<Buffer> createState() => _BufferState();
}

class _BufferState extends State<Buffer> {
  @override
  Widget build(BuildContext context) {
    final bLEProvider = Provider.of<BLEProvider>(context, listen: true);
    // go to next page
    void sendData() {
      var command =
          '${widget.userCart.getFuel()!.id},${widget.userCart.getPrice()}';
      bLEProvider.sendCommand(command);
    }

    void goToNextPage() {
      sendData();
      Navigator.pushNamed(context, "/fueling");
    }

    return GestureDetector(
      onLongPress: goToNextPage,
      // onTap: sendData,
      child: Material(
        child: Container(
            decoration: const BoxDecoration(
                gradient: AppColor.backgroundGradient,
                image: DecorationImage(
                    image: AssetImage("lib/images/line-graphic.png"),
                    fit: BoxFit.cover)),
            child: const SafeArea(
              child: Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "คอนเฟิร์มออเดอร์เรียบร้อย!",
                    style: TextStyle(
                      height: 1,
                      fontSize: 48,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Prompt",
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  SpinKitWaveSpinner(
                    color: Colors.white,
                    size: 400.0,
                  ),
                ],
              )),
            )),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class Buffer extends StatelessWidget {
//   const Buffer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return (SizedBox(
//       height: 1000,
//       width: 1000,
//       child: Lottie.asset('lib/images/tank.json'),
//     ));
//   }
// }
