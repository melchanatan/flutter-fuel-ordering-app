import 'package:flutter/material.dart';
import 'package:fuel_ordering_tablet/constants/colors.dart';

class Suggestion extends StatefulWidget {
  const Suggestion({super.key});

  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // color: Colors.black,
          gradient: AppColor.backgroundGradient,
          image: DecorationImage(
              image: AssetImage("lib/images/line-graphic.png"),
              fit: BoxFit.cover)),
    );
  }
}
