import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/constants/strings.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/core/params/signup_params.dart';
import 'package:lms/core/widgets/button.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_event.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_state.dart';
import 'package:lms/feature/auth/presentation/widgets/auth_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.06.w(context)),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    Strings.signUp,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 0.01.h(context),
                  ),
                  Text(
                    Strings.createAccount,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 0.014.toRes(context)),
                  ),
                  SizedBox(
                    height: 0.04.h(context),
                  ),
                  AuthTextfield(
                      title: Strings.fullName,
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value == "") {
                          return "Name is required";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 0.02.h(context),
                  ),
                  AuthTextfield(
                    title: Strings.email,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
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
                    height: 0.02.h(context),
                  ),
                  AuthTextfield(
                    title: Strings.password,
                    isPasswordField: true,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      } else if (value != confirmPasswordController.text) {
                        return "Password don't match";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 0.02.h(context),
                  ),
                  AuthTextfield(
                    title: Strings.confirmPassword,
                    isPasswordField: true,
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      } else if (value != passwordController.text) {
                        return "Password don't match";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 0.04.h(context),
                  ),
                  state is AuthLogginIn
                      ? const CircularProgressIndicator(
                          color: ColorPalette.primaryColor,
                        )
                      : Button(
                          title: Strings.signUp,
                          onTap: () {
                            if (formKey.currentState?.validate() ?? false) {
                              context
                                  .read<AuthBloc>()
                                  .add(AuthSignUp(SigupParams(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    name: nameController.text.trim(),
                                  )));
                            }
                          },
                        ),
                  SizedBox(
                    height: 0.05.h(context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.haveAccount,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: 0.012.toRes(context),
                                  color: Colors.black54,
                                ),
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(
                        width: 0.05.w(context),
                      ),
                      InkWell(
                        onTap: () {
                          context.go("/signin");
                        },
                        child: Text(
                          Strings.signinHere,
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontSize: 0.012.toRes(context),
                                    fontWeight: FontWeight.w600,
                                    color: ColorPalette.primaryColor,
                                  ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
