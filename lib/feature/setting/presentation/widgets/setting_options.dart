import 'package:flutter/material.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/extension/estension.dart';

class SettingOptions extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingOptions({
    super.key,
    required this.icon,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 0.015.h(context), horizontal: 0.04.w(context)),
        child: Row(
          children: [
            Icon(icon, size: 24, color: ColorPalette.primaryColor),
            SizedBox(width: 0.03.w(context)),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            Icon(Icons.keyboard_arrow_right, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }
}
