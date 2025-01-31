import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/core/widgets/button.dart';
import 'package:lms/feature/payment/presentation/cubit/progress_cubit.dart';
import 'package:lms/feature/payment/presentation/widgets/cofirmation.dart';
import 'package:lms/feature/payment/presentation/widgets/overview.dart';
import 'package:lms/feature/payment/presentation/widgets/payment_option.dart';
import 'package:lms/feature/payment/presentation/widgets/payment_progress.dart';

class PaymentIntentPage extends StatelessWidget {
  const PaymentIntentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProgressCubit(),
      child: const PaymentIntent(),
    );
  }
}

class PaymentIntent extends StatelessWidget {
  const PaymentIntent({super.key});

  static const _pageList = [
    Overview(),
    PaymentOption(),
    Confirmation(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: BlocBuilder<ProgressCubit, int>(
        builder: (context, state) {
          int currentIndex = state;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
            child: Column(
              children: [
                const PaymentProgress(),
                Expanded(child: _pageList[currentIndex - 1]),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Button(
        width: 0.9.w(context),
        title: "Enroll",
        onTap: () {
          final progressCubit = context.read<ProgressCubit>();
          progressCubit.increment();
        },
      ),
    );
  }
}
