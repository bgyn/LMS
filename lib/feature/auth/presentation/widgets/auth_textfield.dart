import 'package:flutter/material.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/extension/estension.dart';

class AuthTextfield extends StatefulWidget {
  final String title;
  final bool? isPasswordField;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const AuthTextfield(
      {super.key,
      required this.title,
      required this.controller,
      this.keyboardType,
      this.validator,
      this.isPasswordField = false});

  @override
  State<AuthTextfield> createState() => _AuthTextfieldState();
}

class _AuthTextfieldState extends State<AuthTextfield> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 0.01.h(context),
        ),
        SizedBox(
          height: 0.06.h(context),
          child: TextFormField(
            obscureText:
                widget.isPasswordField ?? false ? !isPasswordVisible : false,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            cursorHeight: 0.03.h(context),
            style: Theme.of(context).textTheme.labelSmall,
            decoration: InputDecoration(
              suffixIcon: widget.isPasswordField ?? false
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: ColorPalette.primaryColor),
              ),
            ),
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}
