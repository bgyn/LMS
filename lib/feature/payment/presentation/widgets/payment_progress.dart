import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/feature/payment/presentation/cubit/progress_cubit.dart';

class PaymentProgress extends StatelessWidget {
  const PaymentProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.15.h(context),
      padding: EdgeInsets.symmetric(horizontal: 0.06.w(context)),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withAlpha(50),
        borderRadius: BorderRadius.circular(12),
      ),
      child: BlocBuilder<ProgressCubit, int>(builder: (context, state) {
        int currentIndex = state;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            circularContainer("1", currentIndex >= 1, "Overview"),
            Expanded(
                child: Divider(
              thickness: 3,
              color:
                  currentIndex >= 2 ? ColorPalette.primaryColor : Colors.black,
            )),
            circularContainer("2", currentIndex >= 2, "Payment Method"),
            Expanded(
                child: Divider(
              thickness: 3,
              color:
                  currentIndex == 3 ? ColorPalette.primaryColor : Colors.black,
            )),
            circularContainer("3", currentIndex == 3, "Confirmation"),
          ],
        );
      }),
    );
  }

  Widget circularContainer(String text, bool isActive, String title) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isActive ? ColorPalette.primaryColor : Colors.black,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        Positioned(
          bottom: -20,
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.black : Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
