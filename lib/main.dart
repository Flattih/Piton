import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/app_startup.dart';
import 'package:piton/core/theme/app_theme.dart';
import 'package:piton/features/auth/widgets/auth_widget.dart';
import 'package:piton/router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: AppStartupWidget(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      onGenerateRoute: generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ref.watch(themeProvider),
      title: 'Piton',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const AuthWidget(),
    );
  }
}
