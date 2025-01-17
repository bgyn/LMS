import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/constants/strings.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/core/widgets/button.dart';
import 'package:lms/feature/auth/presentation/widgets/auth_textfield.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.06.w(context)),
        child: SingleChildScrollView(
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
                controller: TextEditingController(),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 0.02.h(context),
              ),
              AuthTextfield(
                title: Strings.email,
                controller: TextEditingController(),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 0.02.h(context),
              ),
              AuthTextfield(
                title: Strings.password,
                isPasswordField: true,
                controller: TextEditingController(),
              ),
              SizedBox(
                height: 0.02.h(context),
              ),
              AuthTextfield(
                title: Strings.confirmPassword,
                isPasswordField: true,
                controller: TextEditingController(),
              ),
              SizedBox(
                height: 0.04.h(context),
              ),
              Button(
                title: Strings.signUp,
                onTap: () {},
              ),
              SizedBox(
                height: 0.05.h(context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.haveAccount,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
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
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
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
  }
}
