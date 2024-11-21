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

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ref.watch(themeProvider),
      title: 'Piton',
      home: const AuthWidget(),
    );
  }
}
