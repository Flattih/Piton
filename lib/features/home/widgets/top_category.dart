import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/core/extension/string_extension.dart';
import 'package:piton/core/theme/app_colors.dart';

enum TopCategoryType { all, classics, horror, romance }

final topCategoryTypeProvider = StateProvider<TopCategoryType>((ref) {
  return TopCategoryType.all;
});

class TopCategory extends ConsumerWidget {
  const TopCategory({
    super.key,
    required this.type,
  });

  final TopCategoryType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(topCategoryTypeProvider) == type;
    return GestureDetector(
      onTap: () {
        ref.read(topCategoryTypeProvider.notifier).update((_) => type);
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: Durations.medium2,
        decoration: BoxDecoration(
            color: isSelected ? AppColors.purpleColor : context.primaryColor, borderRadius: BorderRadius.circular(5)),
        child: Text(
          type.name.capitalize(),
          style: context.textTheme.bodyLarge
              ?.copyWith(color: isSelected ? Colors.white : AppColors.hintColor, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
