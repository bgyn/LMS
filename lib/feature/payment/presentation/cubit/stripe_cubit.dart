import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:lms/feature/payment/presentation/cubit/stripe_state.dart';

class StripeCubit extends Cubit<StripeState> {
  StripeCubit() : super(StripeInitial());

  Future<void> intializePaymentSheet(String clientSecret) async {
    try {
      emit(StripeLoading());
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: "Learning Management System",
          paymentIntentClientSecret: clientSecret,
          style: ThemeMode.dark,
        ),
      );
      emit(StripePaymentSheetReady());
    } catch (e) {
      emit(StripePaymentSheetError(e.toString()));
    }
  }

  Future<void> presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      emit(StripePaymentScuccess());
    } catch (e) {
      emit(StripePaymentSheetError(e.toString()));
    }
  }
}
