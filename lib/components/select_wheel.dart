import 'package:flutter/material.dart';
import 'package:fuel_ordering_tablet/constants/colors.dart';
import 'package:selector_wheel/selector_wheel.dart';

class SelectWheel extends StatefulWidget {
  final Function(String value, int index) onValueChanged;
  final int index;

  const SelectWheel(
      {super.key, required this.onValueChanged, required this.index});

  @override
  State<SelectWheel> createState() => _SelectWheelState();
}

class _SelectWheelState extends State<SelectWheel> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: 3,
        child: Theme(
            data: ThemeData(
              textTheme: Theme.of(context).textTheme.copyWith(
                    titleLarge:
                        Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontFamily: "PlexSans",
                              fontSize: 30.0,
                            ),
                  ),
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    surface: Colors.transparent,
                    onSurface: Colors.white,
                    secondaryContainer: Colors.transparent,
                  ),
            ),
            child: Container(
              width: 140,
              height: 150,
              child: SelectorWheel(
                childCount: 10,
                convertIndexToValue: (int index) {
                  return SelectorWheelValue(
                    label: (index).toString(),
                    value: index,
                    index: index,
                  );
                },
                onValueChanged: (SelectorWheelValue<int> value) {
                  // print the value that was selected
                  widget.onValueChanged(value.label, widget.index);
                },
              ),
            )));
  }
}
