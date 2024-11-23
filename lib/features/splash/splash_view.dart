import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/core/constants/shared_pref.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/features/auth/views/sign_in_view.dart';
import 'package:piton/features/home/views/home_view.dart';
import 'package:piton/features/splash/splash_screen_content.dart';

// SplashView widget to handle the splash screen logic
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

    // Navigate after a delay of 3 seconds to either Home or SignIn page
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        final isRemembered = SharedPref.isTokenExist(ref);

        // Check if a token exists to decide whether to navigate to Home or SignIn page
        isRemembered
            ? context.toNamedAndRemoveUntil(HomeView.routeName)
            : context.toNamedAndRemoveUntil(SignInView.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Display the splash screen content
    return const SplashScreenContent();
  }
}
