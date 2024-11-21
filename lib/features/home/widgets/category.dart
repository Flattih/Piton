import 'package:flutter/material.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/core/theme/app_colors.dart';

class Category extends StatelessWidget {
  const Category({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      duration: Durations.medium2,
      decoration: BoxDecoration(color: AppColors.purpleColor, borderRadius: BorderRadius.circular(5)),
      child: Text(
        "All",
        style: context.textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
