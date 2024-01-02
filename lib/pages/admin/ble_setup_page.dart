import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:fuel_ordering_tablet/utils/widget.dart';
import 'package:provider/provider.dart';

class BleSetup extends StatefulWidget {
  const BleSetup({Key? key}) : super(key: key);

  @override
  State<BleSetup> createState() => _BleSetupState();
}

class _BleSetupState extends State<BleSetup> {
  static const menuItems = <String>["Scan BLE Devices"];
  StreamController? controller;
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;

    if ((!controller!.isClosed) && (!_isDisposed == true)) {
      controller!.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bLEProvider = Provider.of<BLEProvider>(context, listen: true);
    controller = StreamController();
    if (controller!.isClosed) {
      controller!.addStream(bLEProvider.getDiscoveredDeviceController.stream);
    }

    if (_isDisposed) return Container();

    final List<PopupMenuItem<String>> _popUpMenuItems = menuItems
        .map((String value) => PopupMenuItem<String>(
              value: value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ble setup",
        ),
        actions: [
          PopupMenuButton<String>(
              onSelected: (String value) {
                if (value == "Scan BLE Devices") {
                  bLEProvider.discoverDevices();
                }
              },
              itemBuilder: (BuildContext context) => _popUpMenuItems),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: StreamBuilder<List<DiscoveredDevice>?>(
                  stream: (!controller!.isClosed)
                      ? bLEProvider.getDiscoveredDeviceController.stream
                      : null,
                  builder: ((context, snapshot) {
                    List<DiscoveredDevice>? scannedDevices = snapshot.data;
                    if (scannedDevices != null) {
                      return ListView.builder(
                          itemCount: scannedDevices.length,
                          itemBuilder: ((context, index) {
                            return Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.bluetooth,
                                    color: Colors.blue[800],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(scannedDevices[index].name,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        Text(scannedDevices[index].id),
                                        Text("$index"),
                                        Text(scannedDevices[index].toString()),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          bLEProvider.connectToScannedDevice(
                                              scannedDevices[index].id,
                                              scannedDevices[index]
                                                  .serviceUuids[0]);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: bLEProvider
                                                        .getDeviceConnectionState ==
                                                    DeviceConnectionState
                                                        .connecting
                                                ? Colors.grey
                                                : bLEProvider
                                                            .getDeviceConnectionState ==
                                                        DeviceConnectionState
                                                            .connected
                                                    ? const Color.fromARGB(
                                                        255, 27, 146, 31)
                                                    : Colors.blue[800]),
                                        child: Text(bLEProvider
                                                    .getDeviceConnectionState ==
                                                DeviceConnectionState.connecting
                                            ? "Connecting..."
                                            : bLEProvider
                                                        .getDeviceConnectionState ==
                                                    DeviceConnectionState
                                                        .connected
                                                ? "Connected"
                                                : "Connect"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }));
                    } else {
                      return Center(
                        child: ElevatedButton(
                            onPressed: () {
                              log("heloewe");
                              if (bLEProvider.getDeviceConnectionState !=
                                  DeviceConnectionState.connecting) {
                                bLEProvider.discoverDevices();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[800]),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                bLEProvider.getScanStatus
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                        ))
                                    : const SizedBox(),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("Scan BLE Devices"),
                              ],
                            )),
                      );
                    }
                  })),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "BLE : ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            bLEProvider.getScanStatus
                                ? const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("searching",
                                          style: TextStyle(fontSize: 15)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        height: kToolbarHeight * 0.2,
                                        width: kToolbarHeight * 0.2,
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Text("scan paused",
                                    style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
