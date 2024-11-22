import 'package:flutter/material.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/core/extension/padding_extension.dart';
import 'package:piton/core/theme/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onTapViewAll;
  const SectionHeader({
    super.key,
    this.title = "Best Seller",
    this.onTapViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: context.width * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: onTapViewAll,
          child: Text(
            "View All",
            style: TextStyle(
              fontSize: context.width * 0.04,
              fontWeight: FontWeight.bold,
              color: AppColors.orangeColor,
            ),
          ).paddingOnly(right: context.lowValue * 1.6),
        ),
      ],
    );
  }
}
