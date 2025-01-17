import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/utils/shared_utility.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    final isOnboarded = SharedUtility.getIsOnboarding();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      if (isOnboarded) {
        context.go("/signin");
      } else {
        context.go("/onboarding");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Page'),
      ),
    );
  }
}
