import 'dart:io';

import 'package:ecommerce_app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class PaymentSelectionScreen extends StatelessWidget {
  const PaymentSelectionScreen({Key? key}) : super(key: key);

  static const String routeName = '/payment-selection';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => PaymentSelectionScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Payment Selection'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Platform.isIOS
                ? RawApplePayButton(
                    type: ApplePayButtonType.inStore,
                    onPressed: () {},
                  )
                : RawGooglePayButton(
                    type: GooglePayButtonType.pay,
                    onPressed: () {},
                  )
          ],
        ),
      ),
    );
  }
}
