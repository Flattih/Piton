import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/features/home/home_view.dart';
import 'package:piton/features/splash/splash_view.dart';

class AuthWidget extends ConsumerWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Local Authentication will be added here
    return false ? const HomeView() : const SplashView();
  }
}
