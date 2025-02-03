import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/constants/images.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/feature/payment/presentation/bloc/payment_bloc.dart';
import 'package:lms/feature/payment/presentation/bloc/payment_state.dart';

class Confirmation extends StatelessWidget {
  const Confirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(builder: (context, state) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 0.01.h(context),
            ),
            Text(state is PaymentSuccess
                ? 'Transaction Completed'
                : 'Transaction Failed'),
            SizedBox(
              height: 0.01.h(context),
            ),
            state is PaymentSuccess
                ? Image.asset(
                    Images.transactionCompleted,
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.error),
          ],
        ),
      );
    });
  }
}
