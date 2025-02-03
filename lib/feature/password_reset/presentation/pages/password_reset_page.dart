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

class PasswordResetPage extends StatefulWidget {
  final String email;
  const PasswordResetPage({super.key, required this.email});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
            Strings.resetPassword,
          ),
        ),
        body: BlocListener<PasswordResetBloc, PasswordResetState>(
          listener: (context, state) {
            if (state is PasswordResetSuccess) {
              context.go(RoutePath.signIn);
            }
          },
          child: BlocBuilder<PasswordResetBloc, PasswordResetState>(
              builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.06.w(context)),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 0.05.h(context),
                    ),
                    AuthTextfield(
                      title: Strings.password,
                      controller: _passwordController,
                    ),
                    SizedBox(
                      height: 0.02.h(context),
                    ),
                    AuthTextfield(
                      title: Strings.confirmPassword,
                      controller: _confirmPasswordController,
                    ),
                    SizedBox(
                      height: 0.05.h(context),
                    ),
                    state is PasswordResetLoading
                        ? const CircularProgressIndicator(
                            color: ColorPalette.primaryColor,
                          )
                        : Button(
                            title: Strings.reset,
                            onTap: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context.read<PasswordResetBloc>().add(
                                    PasswordReset(widget.email,
                                        _passwordController.text));
                              }
                            },
                          )
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
