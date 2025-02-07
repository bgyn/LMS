import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/constants/strings.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_event.dart';
import 'package:lms/feature/setting/presentation/widgets/setting_options.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text(Strings.setting),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 0.04.w(context),
        ),
        child: Column(
          children: [
            SettingOptions(
              icon: Icons.bookmarks_sharp,
              onTap: () {},
              title: Strings.termsAndCondidtion,
            ),
            SettingOptions(
              icon: Icons.help_center,
              onTap: () {},
              title: Strings.helpCenter,
            ),
            SettingOptions(
              icon: Icons.logout,
              onTap: () {
                context.read<AuthBloc>().add(AuthSignOut());
              },
              title: Strings.logout,
            ),
          ],
        ),
      ),
    );
  }
}
