import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:fuel_ordering_tablet/utils/widget.dart';
import 'package:provider/provider.dart';

class BleButton extends StatelessWidget {
  const BleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bLEProvider = Provider.of<BLEProvider>(context, listen: true);

    return GestureDetector(
      onTap: () => {Navigator.pushNamed(context, "/bleSetup")},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(2, 4))
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Icon(Icons.bluetooth,
            size: 40,
            color: (bLEProvider.getDeviceConnectionState ==
                    DeviceConnectionState.connected)
                ? Colors.blue
                : Colors.red),
      ),
    );
  }
}
