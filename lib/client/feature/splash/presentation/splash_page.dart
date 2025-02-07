import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/client/config/theme/theme.dart';
import 'package:lms/client/core/constants/images.dart';
import 'package:lms/client/core/extension/estension.dart';
import 'package:lms/client/feature/splash/presentation/cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashCubit, bool>(
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(Images.logo),
                SizedBox(
                  height: 0.1.h(context),
                ),
                !state
                    ? const CircularProgressIndicator(
                        color: ColorPalette.primaryColor,
                      )
                    : const SizedBox.shrink()
              ],
            ),
          );
        },
      ),
    );
  }
}
