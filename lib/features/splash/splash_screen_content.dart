import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:piton/core/constants/image_constants.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/core/extension/padding_extension.dart';
import 'package:piton/core/lang/locale_keys.g.dart';
import 'package:piton/core/theme/app_colors.dart';
import 'package:piton/features/auth/views/sign_in_view.dart';

class SplashScreenContent extends StatelessWidget {
  const SplashScreenContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBgColor,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            // Logo
            Expanded(
              flex: 3,
              child: Center(
                child: Image.asset(
                  Images.logo,
                  fit: BoxFit.contain,
                ),
              ).paddingSymmetric(horizontal: 40),
            ),

            const Spacer(),

            // Buttons
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.toNamed(SignInView.routeName);
                    },
                    child: const Text(
                      LocaleKeys.login,
                    ).tr(),
                  ),
                ),
                const Gap(10),
                TextButton(
                  onPressed: () {
                    context.toNamedAndRemoveUntil(SignInView.routeName);
                  },
                  child: const Text(
                    LocaleKeys.skip,
                  ).tr(),
                ),
              ],
            ).paddingSymmetric(horizontal: 20),
          ],
        ),
      ),
    );
  }
}
