import 'package:flutter/material.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/core/extension/padding_extension.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String text;
  const CustomSliverAppBar({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      floating: true,
      actions: [
        Text(
          text,
          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ).paddingOnly(right: 20)
      ],
    );
  }
}
