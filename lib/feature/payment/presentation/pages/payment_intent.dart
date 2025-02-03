import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/core/widgets/button.dart';
import 'package:lms/feature/payment/presentation/bloc/payment_bloc.dart';
import 'package:lms/feature/payment/presentation/bloc/payment_event.dart';
import 'package:lms/feature/payment/presentation/bloc/payment_state.dart';
import 'package:lms/feature/payment/presentation/cubit/progress_cubit.dart';
import 'package:lms/feature/payment/presentation/cubit/stripe_cubit.dart';
import 'package:lms/feature/payment/presentation/cubit/stripe_state.dart';
import 'package:lms/feature/payment/presentation/widgets/cofirmation.dart';
import 'package:lms/feature/payment/presentation/widgets/overview.dart';
import 'package:lms/feature/payment/presentation/widgets/payment_option.dart';
import 'package:lms/feature/payment/presentation/widgets/payment_progress.dart';

class PaymentIntentPage extends StatelessWidget {
  final int _amount;
  final String _courseId;
  const PaymentIntentPage(
      {super.key, required int amount, required String courseId})
      : _amount = amount,
        _courseId = courseId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProgressCubit(),
      child: PaymentIntent(
        amount: _amount,
        courseId: _courseId,
      ),
    );
  }
}

class PaymentIntent extends StatelessWidget {
  final int _amount;
  final String _courseId;
  const PaymentIntent(
      {super.key, required int amount, required String courseId})
      : _amount = amount,
        _courseId = courseId;

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
      body: MultiBlocListener(
        listeners: [
          BlocListener<PaymentBloc, PaymentState>(
            listener: (context, state) {
              if (state is PaymentIntentSuccess) {
                context
                    .read<StripeCubit>()
                    .intializePaymentSheet(state.clientSecret);
              }
              if (state is PaymentSuccess) {
                context.read<ProgressCubit>().increment();
              }
            },
          ),
          BlocListener<StripeCubit, StripeState>(listener: (context, state) {
            if (state is StripePaymentSheetReady) {
              context.read<StripeCubit>().presentPaymentSheet();
            }
            if (state is StripePaymentScuccess) {
              context.read<PaymentBloc>().add(PaymentSuccessEvent());
            }
          })
        ],
        child: BlocBuilder<ProgressCubit, int>(
          builder: (context, state) {
            int currentIndex = state;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PaymentProgress(),
                  Expanded(child: _pageList[currentIndex - 1]),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          BlocBuilder<ProgressCubit, int>(builder: (context, state) {
        return Button(
          width: 0.9.w(context),
          title: state == 3 ? "Done" : "Enroll",
          onTap: () {
            if (state == 2) {
              context
                  .read<PaymentBloc>()
                  .add(InitiatePaymentIntent("${_amount * 100}", _courseId));
              return;
            }
            if (state == 3) {
              context.pop();
              return;
            }
            context.read<ProgressCubit>().increment();
          },
        );
      }),
    );
  }
}
