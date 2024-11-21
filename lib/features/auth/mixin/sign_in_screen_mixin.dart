import 'package:flutter/material.dart';
import 'package:piton/features/auth/views/sign_in_view.dart';

mixin SignInScreenMixin on State<SignInView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
