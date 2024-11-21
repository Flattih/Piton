import 'package:flutter/material.dart';
import 'package:piton/features/auth/views/sign_up_view.dart';

mixin SignUpScreenMixin on State<SignUpView> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
