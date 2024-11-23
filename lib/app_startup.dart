import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:piton/core/common/app_loader.dart';
import 'package:piton/core/lang/language_manager.dart';
import 'package:piton/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      data: (_) => LanguageManager(child: const MyApp()),
      loading: () => const AppStartupLoadingWidget(),
      error: (error, stack) => AppStartupErrorWidget(
        message: error.toString(),
        onRetry: () {
          ref.invalidate(appStartupProvider);
        },
      ),
    );
  }
}

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async => SharedPreferences.getInstance());

final appStartupProvider = FutureProvider<void>((ref) async {
  ref.onDispose(() {
    // Ensure we invalidate all the providers we depend on
    ref.invalidate(sharedPreferencesProvider);
  });

  // All async app initialization code goes here
  final results = await Future.wait([
    ref.watch(sharedPreferencesProvider.future),
    EasyLocalization.ensureInitialized(),
    getApplicationDocumentsDirectory(),
  ]);
  Hive.defaultDirectory = (results[2] as Directory).path;
});

class AppStartupLoadingWidget extends StatelessWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Loader(),
      ),
    );
  }
}

class AppStartupErrorWidget extends StatelessWidget {
  const AppStartupErrorWidget({super.key, required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message, style: Theme.of(context).textTheme.headlineSmall),
              const Gap(16),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
