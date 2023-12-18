import 'package:flutter/material.dart';
import 'package:fuel_ordering_tablet/models/user_cart.dart';
import 'package:fuel_ordering_tablet/pages/admin/ble_setup_page.dart';
import 'package:fuel_ordering_tablet/pages/buffer_page.dart';
import 'package:fuel_ordering_tablet/pages/custom_price_select_page.dart';
import 'package:fuel_ordering_tablet/pages/fuel_select_page.dart';
import 'package:fuel_ordering_tablet/pages/fueling_page.dart';
import 'package:fuel_ordering_tablet/pages/payment_select_page.dart';
import 'package:fuel_ordering_tablet/pages/price_select_page.dart';
import 'package:fuel_ordering_tablet/pages/suggestion_page.dart';
import 'package:fuel_ordering_tablet/pages/summary_page.dart';
import 'package:fuel_ordering_tablet/utils/provider_consumer.dart';
import 'package:fuel_ordering_tablet/utils/provider_scope.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    UserCart userCart = UserCart();

    return ProviderScope(
        child: ProviderConsumer(builder: ((context, bLEProvider) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/fuelSelect',
          theme: ThemeData(
              checkboxTheme: CheckboxThemeData(
            checkColor: MaterialStateProperty.resolveWith((_) => Colors.white),
            fillColor:
                MaterialStateProperty.resolveWith((_) => Colors.transparent),
            side: AlwaysActiveBorderSide(),
          )),
          routes: {
            '/suggestion': (context) => const Suggestion(),
            '/fuelSelect': (context) => FuelSelect(userCart: userCart),
            '/priceSelect': (context) => PriceSelect(userCart: userCart),
            '/paymentSelect': (context) => PaymentSelect(userCart: userCart),
            '/summary': (context) => Summary(userCart: userCart),
            // '/summary': (context) => const Buffer(),
            '/fueling': (context) => Fueling(userCart: userCart),
            '/buffer': (context) => Buffer(userCart: userCart),
            '/customPriceSelect': (context) =>
                CustomPriceSelect(userCart: userCart),
            '/bleSetup': (context) => const BleSetup()
          });
    })));
  }
}

class AlwaysActiveBorderSide extends MaterialStateBorderSide {
  @override
  BorderSide? resolve(_) => const BorderSide(
        color: Colors.white,
        width: 1.5,
      );
}
