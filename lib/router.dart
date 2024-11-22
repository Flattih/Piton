import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piton/features/auth/views/sign_in_view.dart';
import 'package:piton/features/auth/views/sign_up_view.dart';
import 'package:piton/features/home/home_view.dart';
import 'package:piton/features/splash/splash_view.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  return switch (routeSettings.name) {
    // Splash Route
    SplashView.routeName => FadePageRoute(builder: (context) => const SplashView()),

    // Auth Routes
    SignUpView.routeName => FadePageRoute(builder: (context) => const SignUpView()),
    SignInView.routeName => FadePageRoute(builder: (context) => const SignInView()),

    // Home Route
    HomeView.routeName => FadePageRoute(builder: (context) => const HomeView()),

    // Default Route
    _ => MaterialPageRoute(builder: (context) => const Scaffold()),
  };
}

// This is a custom CupertinoPageRoute that fades in the new page when navigating to it.
class FadePageRoute<T> extends CupertinoPageRoute<T> {
  FadePageRoute({required super.builder});

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    final widget = super.buildTransitions(context, animation, secondaryAnimation, child);
    if (widget is CupertinoPageTransition) {
      return FadeTransition(
        opacity: animation,
        child: widget.child,
      );
    } else {
      return widget;
    }
  }
}
