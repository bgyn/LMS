import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/config/route/route_path.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/constants/strings.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/core/widgets/button.dart';
import 'package:lms/feature/auth/presentation/widgets/auth_textfield.dart';
import 'package:lms/feature/password_reset/presentation/bloc/password_reset_bloc.dart';
import 'package:lms/feature/password_reset/presentation/bloc/password_reset_event.dart';
import 'package:lms/feature/password_reset/presentation/bloc/password_reset_state.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
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
          Strings.forgotPassword,
        ),
      ),
      body: BlocListener<PasswordResetBloc, PasswordResetState>(
        listener: (context, state) {
          if (state is PasswordResetRequestSuccess) {
            context.push(RoutePath.verifyOtp, extra: _emailController.text);
          }
        },
        child: BlocBuilder<PasswordResetBloc, PasswordResetState>(
            builder: (cotnext, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.06.w(context)),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 0.1.h(context),
                  ),
                  AuthTextfield(
                    title: Strings.enterYourEmail,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 0.05.h(context),
                  ),
                  state is PasswordResetLoading
                      ? const CircularProgressIndicator(
                          color: ColorPalette.primaryColor)
                      : Button(
                          title: Strings.send,
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<PasswordResetBloc>().add(
                                  PasswordResetSubmitted(
                                      _emailController.text));
                            }
                          },
                        )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
