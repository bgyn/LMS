import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/constants/images.dart';
import 'package:lms/core/constants/strings.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/core/utils/shared_utility.dart';
import 'package:lms/feature/onboarding/presentation/cubit/onboarding_cubit.dart';

class OnBoardingpage extends StatefulWidget {
  const OnBoardingpage({super.key});

  @override
  State<OnBoardingpage> createState() => _OnBoardingpageState();
}

class _OnBoardingpageState extends State<OnBoardingpage> {
  static const _onboardingData = [
    {
      'title': Strings.onboardingTitle1,
      'subtitle': Strings.onboardingSubtitle1,
      'image': Images.onboarding1,
    },
    {
      'title': Strings.onboardingTitle2,
      'subtitle': Strings.onboardingSubtitle2,
      'image': Images.onboarding2,
    },
    {
      'title': Strings.onboardingTitle3,
      'subtitle': Strings.onboardingSubtitle3,
      'image': Images.onboarding3,
    },
    {
      'title': Strings.onboardingTitle4,
      'subtitle': Strings.onboardingSubtitle4,
      'image': Images.onboarding4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: () async {
                await SharedUtility.setIsOnboarding();
                if (!context.mounted) return;
                context.go("/signin");
              },
              child: Text(
                "Skip",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: BlocProvider(
          create: (context) => OnboardingCubit(),
          child: BlocBuilder<OnboardingCubit, int>(builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onHorizontalDragEnd: (details) async {
                  if (details.primaryVelocity != null) {
                    if (details.primaryVelocity! > 0) {
                      state != 0
                          ? context.read<OnboardingCubit>().back()
                          : null;
                    } else if (details.primaryVelocity! < 0) {
                      if (state == _onboardingData.length - 1) {
                        await SharedUtility.setIsOnboarding();
                        if (!context.mounted) return;
                        context.go("/signin");
                      } else {
                        context.read<OnboardingCubit>().next();
                      }
                    }
                  }
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 0.02.h(context),
                    ),
                    SizedBox(
                      height: 0.4.h(context),
                      child: Image.asset(_onboardingData[state]['image']!),
                    ),
                    SizedBox(
                      height: 0.02.h(context),
                    ),
                    Text(
                      _onboardingData[state]['title']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 0.018.toRes(context),
                      ),
                    ),
                    SizedBox(
                      height: 0.02.h(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        _onboardingData[state]['subtitle']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 0.012.toRes(context),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.02.h(context),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _onboardingData.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: index == state
                                ? ColorPalette.primaryColor
                                : Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.02.h(context),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorPalette.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fixedSize: Size(0.6.w(context), 0.06.h(context)),
                        ),
                        onPressed: () async {
                          if (state == _onboardingData.length - 1) {
                            await SharedUtility.setIsOnboarding();
                            if (!context.mounted) return;
                            context.go("/signin");
                          } else {
                            context.read<OnboardingCubit>().next();
                          }
                        },
                        child: Text(
                          "CONTINUE",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: Colors.white,
                                  fontSize: 0.017.toRes(context)),
                        ))
                  ],
                ),
              ),
            );
          })),
    );
  }
}
