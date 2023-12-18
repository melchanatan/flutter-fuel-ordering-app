import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppColor {
  AppColor._();
  static const Color primaryBlue = Color(0xFF3298E5);
  static const Color primaryGreen = Color(0xFFD5FFD1);
  static const Color darkenGreen = Color(0xFF4FDDBB);

  static const Gradient backgroundGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.165, 0.70, 0.9],
    colors: [
      AppColor.primaryBlue,
      AppColor.darkenGreen,
      AppColor.primaryGreen,
    ],
  );

  static Gradient glassGradientLight = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        -.043,
        0.45,
        1.06,
      ],
      colors: [
        Colors.white.withOpacity(.4),
        Colors.white.withOpacity(.2),
        Colors.white.withOpacity(.3)
      ]);
}
