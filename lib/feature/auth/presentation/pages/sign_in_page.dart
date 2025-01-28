import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/config/route/route_path.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/constants/strings.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/core/params/sign_params.dart';
import 'package:lms/core/widgets/button.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_event.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_state.dart';
import 'package:lms/feature/auth/presentation/widgets/auth_textfield.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                    Strings.signIn,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 0.01.h(context),
                  ),
                  Text(
                    Strings.signInWithAccount,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 0.014.toRes(context)),
                  ),
                  SizedBox(
                    height: 0.04.h(context),
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
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 0.02.h(context),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => {
                        GoRouter.of(context).push(RoutePath.forgotPassword),
                      },
                      child: Text(
                        "${Strings.forgotPassword}?",
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: 0.012.toRes(context),
                                  color: Colors.black54,
                                ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.04.h(context),
                  ),
                  state is AuthLogginIn
                      ? const CircularProgressIndicator(
                          color: ColorPalette.primaryColor,
                        )
                      : Button(
                          title: Strings.signIn,
                          onTap: () {
                            if (formKey.currentState?.validate() ?? false) {
                              context.read<AuthBloc>().add(AuthSignIn(
                                  SiginParams(
                                      email: emailController.text.trim(),
                                      password:
                                          passwordController.text.trim())));
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
                        Strings.dontHaveAccount,
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
                          context.go("/signup");
                        },
                        child: Text(
                          Strings.signupHere,
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
