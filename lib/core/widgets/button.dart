import 'package:flutter/material.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/extension/estension.dart';

class Button extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final Color? color;
  final BorderRadius? borderRadius;
  final double? width;
  const Button(
      {super.key,
      required this.title,
      required this.onTap,
      this.borderRadius,
      this.width,
      this.color = ColorPalette.primaryColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 0.06.h(context),
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: Colors.white, fontSize: 0.016.toRes(context)),
          ),
        ),
      ),
    );
  }
}
