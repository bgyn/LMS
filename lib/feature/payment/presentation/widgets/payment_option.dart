import 'package:flutter/material.dart';
import 'package:lms/core/extension/estension.dart';

class PaymentOption extends StatefulWidget {
  const PaymentOption({super.key});

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  String selectedPayment = "Stripe";

  final List<String> paymentOptions = ["Stripe"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 0.01.h(context),
        ),
        Text(
          "Select Payment Method",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        //stripe option
        ...paymentOptions.map((option) {
          return RadioMenuButton<String>(
            value: option,
            groupValue: selectedPayment,
            onChanged: (value) {
              setState(() {
                selectedPayment = value!;
              });
            },
            child: Text(option),
          );
        }),
      ],
    );
  }
}
