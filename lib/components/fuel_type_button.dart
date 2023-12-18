import 'package:flutter/material.dart';
import 'package:fuel_ordering_tablet/models/fuel.dart';

class FuelTypeButton extends StatefulWidget {
  Fuel fuel;
  void Function(Fuel fuel) onTap;

  FuelTypeButton({super.key, required this.fuel, required this.onTap});

  @override
  State<FuelTypeButton> createState() => _FuelTypeButtonState();
}

class _FuelTypeButtonState extends State<FuelTypeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(widget.fuel),
      child: Container(
        height: 200,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: const [
                  -.043,
                  0.45,
                  1.06,
                ],
                colors: [
                  widget.fuel.color,
                  widget.fuel.color.withOpacity(.47),
                  widget.fuel.color.withOpacity(.6)
                ])),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Fuel Title text
                  Text(widget.fuel.name,
                      style: const TextStyle(
                        height: 1,
                        fontSize: 48,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Prompt",
                        color: Colors.white,
                      )),

                  // Fuel Subtitle text
                  Text(widget.fuel.subname,
                      style: const TextStyle(
                        height: 1,
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Prompt",
                      ))
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Text(widget.fuel.quality,
                  style: const TextStyle(
                    height: 1.18,
                    fontSize: 100,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontFamily: "Prompt",
                  ))
            ]),
      ),
    );
  }
}
