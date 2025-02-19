import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/config/route/route_path.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/constants/strings.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/core/widgets/button.dart';
import 'package:lms/feature/password_reset/presentation/bloc/password_reset_bloc.dart';
import 'package:lms/feature/password_reset/presentation/bloc/password_reset_event.dart';
import 'package:lms/feature/password_reset/presentation/bloc/password_reset_state.dart';
import 'package:lms/feature/password_reset/presentation/widgets/otp_textfield.dart';

class VerifyOtpPage extends StatefulWidget {
  final String email;
  const VerifyOtpPage({super.key, required this.email});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  String _otp = '';

  String _getOtp() {
    return _controllers.map((controller) => controller.text).join('');
  }

  Future<void> _verifyOtp() async {
    String otp = _getOtp();

    if (otp.length == 6) {
      context.read<PasswordResetBloc>().add(PasswordResetOtpVerify(
            widget.email,
            otp,
          ));
    } else {}
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              context.pop();
            },
          ),
          centerTitle: true,
          title: const Text(
            Strings.verifyOtp,
          ),
        ),
        body: BlocListener<PasswordResetBloc, PasswordResetState>(
          listener: (context, state) {
            if (state is PasswordOtpVerifySuccess) {
              final body = {
                'email': widget.email,
                'token': state.resetToken,
              };
              context.push(RoutePath.resetPassword, extra: jsonEncode(body));
            }
          },
          child: BlocBuilder<PasswordResetBloc, PasswordResetState>(
              builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.06.w(context)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 0.04.h(context)),
                    const Text(
                      'Enter the 6-digit OTP sent to your email',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 0.02.h(context)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return OtpTextField(
                          index: index,
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          onChanged: (value) {
                            setState(() {
                              _otp = _getOtp();
                            });
                          },
                        );
                      }),
                    ),
                    SizedBox(height: 0.02.h(context)),
                    state is PasswordResetLoading
                        ? const CircularProgressIndicator(
                            color: ColorPalette.primaryColor,
                          )
                        : Button(
                            title: Strings.verifyOtp,
                            onTap: () => _otp.length == 6 ? _verifyOtp() : null,
                            color: _otp.length == 6
                                ? ColorPalette.primaryColor
                                : Colors.grey,
                          )
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
