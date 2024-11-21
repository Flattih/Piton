import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:piton/core/common/app_loader.dart';
import 'package:piton/core/common/title_with_text_field.dart';
import 'package:piton/core/constants/image_constants.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/core/extension/padding_extension.dart';
import 'package:piton/core/extension/string_extension.dart';
import 'package:piton/core/theme/app_colors.dart';
import 'package:piton/features/auth/mixin/sign_in_screen_mixin.dart';
import 'package:piton/features/auth/view_model/auth_view_model.dart';
import 'package:piton/features/auth/views/sign_up_view.dart';
import 'package:piton/features/home/home_view.dart';
import 'package:piton/models/auth/req/sign_in_req.dart';
import 'package:piton/models/auth/req/sign_up_req.dart';

final rememberMeProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

class SignInView extends ConsumerStatefulWidget {
  static const routeName = '/sign-in';
  const SignInView({super.key});

  @override
  ConsumerState<SignInView> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInView> with SignInScreenMixin {
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
                        flex: 1,
                        child: Center(
                          child: Image.asset(
                            Images.logo,
                            width: 100,
                            height: 65,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      // Spacing between Logo and Welcome
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),

                      // Welcome Text Section
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome back!",
                              style: context.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600, color: const Color(0xFF6B6B87)),
                            ),
                            const Gap(10),
                            Text(
                              "Login to your account",
                              style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Spacing between Register text and form
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),

                      // Form Fields Section
                      Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TitleWithTextField(
                              title: "E-mail",
                              hintText: "john@mail.com",
                              controller: emailController,
                              validator: (value) => value?.validateEmail(),
                            ),
                            const Gap(16),
                            TitleWithTextField(
                              title: "Password",
                              hintText: "\u2022\u2022\u2022\u2022\u2022\u2022",
                              controller: passwordController,
                              validator: (value) => value?.validatePassword(),
                            ),
                            const Gap(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      child: Consumer(
                                        builder: (context, ref, child) {
                                          final rememberMeValue = ref.watch(rememberMeProvider);
                                          return Checkbox(
                                            value: rememberMeValue,
                                            onChanged: (value) {
                                              ref.read(rememberMeProvider.notifier).update((_) => value ?? false);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    const Gap(5),
                                    Text(
                                      "Remember me",
                                      style: context.textTheme.labelLarge
                                          ?.copyWith(fontWeight: FontWeight.w700, color: AppColors.purpleColor),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.toReplacementNamed(SignUpView.routeName);
                                  },
                                  child: const Text("Register"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Login Button Section
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _handleLogin,
                                child: const Text("Login"),
                              ),
                            ),
                          ],
                        ).paddingOnly(bottom: 30),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  void _handleLogin() {
    if (formKey.currentState?.validate() ?? false) {
      final signInReq = SignInReq(email: emailController.text, password: passwordController.text);
      ref.read(authViewModelPr.notifier).signInWithEmailAndPassword(signInReq).then(
        (isSuccess) {
          if (isSuccess) {
            context.toNamedAndRemoveUntil(HomeView.routeName);
          }
        },
      );
    }
  }
}
