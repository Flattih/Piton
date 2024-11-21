import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:piton/app_startup.dart';
import 'package:piton/core/constants/image_constants.dart';
import 'package:piton/core/constants/shared_pref.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/core/extension/padding_extension.dart';
import 'package:piton/core/extension/string_extension.dart';
import 'package:piton/core/theme/app_colors.dart';
import 'package:piton/features/auth/views/sign_in_view.dart';
import 'package:piton/features/home/home_view.dart';

class SplashView extends ConsumerStatefulWidget {
  static const routeName = '/splash';

  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        final isRemembered = SharedPref.isTokenExist(ref);

        isRemembered
            ? context.toNamedAndRemoveUntil(HomeView.routeName)
            : context.toNamedAndRemoveUntil(SignInView.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBgColor,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            // Logo
            Expanded(
              flex: 3,
              child: Center(
                child: Image.asset(
                  Images.logo,
                  fit: BoxFit.contain,
                ),
              ).paddingSymmetric(horizontal: 40),
            ),

            const Spacer(),

            // Buttons
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.toNamed(SignInView.routeName);
                    },
                    child: const Text(
                      'Login',
                    ),
                  ),
                ),
                const Gap(10),
                TextButton(
                  onPressed: () {
                    context.toNamedAndRemoveUntil(SignInView.routeName);
                  },
                  child: const Text(
                    'Skip',
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 20),
          ],
        ),
      ),
    );
  }
}
