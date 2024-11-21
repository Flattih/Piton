import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:piton/core/common/app_loader.dart';
import 'package:piton/core/common/title_with_text_field.dart';
import 'package:piton/core/constants/image_constants.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/core/extension/string_extension.dart';
import 'package:piton/features/auth/mixin/sign_up_screen_mixin.dart';
import 'package:piton/features/auth/view_model/auth_view_model.dart';
import 'package:piton/features/auth/views/sign_in_view.dart';
import 'package:piton/features/home/home_view.dart';
import 'package:piton/models/auth/req/sign_up_req.dart';

class SignUpView extends ConsumerStatefulWidget {
  static const String routeName = "/sign_up";
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpView> with SignUpScreenMixin {
  @override
  Widget build(BuildContext context) {
    ref.listen(
      authViewModelPr,
      (_, state) {
        if (state.hasError) {
          Fluttertoast.showToast(
            msg: state.error.toString(),
          );
        }
      },
    );
    final isLoading = ref.watch(authViewModelPr.select((value) => value.isLoading));
    return isLoading
        ? const LoadingView()
        : Scaffold(
            body: SafeArea(
              child: Padding(
                padding: context.paddingNormalHorizontal,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo Section
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Image.asset(
                            Images.logo,
                            width: 100,
                            height: 65,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      // Welcome Text Section
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Welcome",
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Gap(10),
                            Text(
                              "Register an account",
                              style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Form Fields Section with Login Button
                      Expanded(
                        flex: 8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TitleWithTextField(
                              title: "Name",
                              hintText: "John Doe",
                              controller: nameController,
                            ),
                            TitleWithTextField(
                              title: "E-mail",
                              hintText: "john@mail.com",
                              controller: emailController,
                              validator: (value) => value?.validateEmail(),
                            ),
                            Column(
                              children: [
                                TitleWithTextField(
                                  title: "Password",
                                  hintText: "\u2022\u2022\u2022\u2022\u2022\u2022",
                                  controller: passwordController,
                                  validator: (value) => value?.validatePassword(),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      context.toReplacementNamed(SignInView.routeName);
                                    },
                                    child: const Text("Login"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Register Button Section
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _handleRegister,
                                child: const Text("Register"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  void _handleRegister() {
    if (formKey.currentState?.validate() ?? false) {
      final signUpReq = SignUpReq(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      ref.read(authViewModelPr.notifier).signUpWithEmail(signUpReq).then(
        (isSuccess) {
          if (isSuccess) {
            context.toNamedAndRemoveUntil(HomeView.routeName);
          }
        },
      );
    }
  }
}
