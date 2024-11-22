import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/core/common/app_loader.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/features/auth/view_model/auth_view_model.dart';
import 'package:piton/features/auth/widgets/biometric_failure_widget.dart';
import 'package:piton/features/splash/splash_screen_content.dart';
import 'package:piton/features/splash/splash_view.dart';

class AuthWidget extends ConsumerWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the isLocalAuthCompletedProvider state
    return ref.watch(isLocalAuthCompletedProvider).when(
      data: (isLocalAuthenticated) {
        // If the user is successfully authenticated via biometrics
        if (isLocalAuthenticated) {
          // Navigate to the SplashView
          return const SplashView();
        }
        // If authentication fails, show the BiometricFailureWidget
        return BiometricFailureWidget(
          onRetry: () async {
            // Retry biometric authentication
            final isLocalAuthSuccess = await ref.read(authViewModelPr.notifier).authenticateWithBiometrics();
            if (isLocalAuthSuccess && context.mounted) {
              // If successful, navigate to SplashView and remove all previous routes
              context.toNamedAndRemoveUntil(SplashView.routeName);
            }
          },
        );
      },
      error: (error, stackTrace) {
        // If an error occurs, show the ErrorScreen
        return ErrorView(
          errorMessage: error.toString(),
          onRetry: () {
            // Retry by refreshing the provider
            ref.refresh(isLocalAuthCompletedProvider);
          },
        );
      },
      loading: () {
        // Show splash screen while the provider state is being fetched
        return const SplashScreenContent();
      },
    );
  }
}
