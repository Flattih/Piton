import 'package:flutter/material.dart';
import 'package:piton/core/constants/image_constants.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/core/extension/padding_extension.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      expandedHeight: 130,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // SliverAppBar'ın yüksekliğini takip et
          final percentCollapsed = (constraints.maxHeight - kToolbarHeight) / 100.0;
          final isCollapsed = percentCollapsed <= 0;
          const logo = Images.logo;

          return FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            title: AnimatedOpacity(
              opacity: isCollapsed ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0), // Hafif üst boşluk için
                child: Center(
                  child: Image.asset(
                    logo,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            background: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      logo,
                      height: 40,
                      fit: BoxFit.contain,
                    ).paddingOnly(top: 8),
                    Text(
                      "Catalog",
                      style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ).paddingOnly(right: 16),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
