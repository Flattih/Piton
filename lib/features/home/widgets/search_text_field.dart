import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/core/common/app_text_field.dart';
import 'package:piton/core/constants/image_constants.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/core/extension/padding_extension.dart';
import 'package:piton/features/home/view_models/home_search_view_model.dart';

class SearchTextField extends ConsumerWidget {
  const SearchTextField({
    super.key,
    required this.searchController,
    required this.prefixIcon,
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController searchController;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final Widget prefixIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(homeSearchViewModelPr);
    return AppTextField(
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      contentPadding: EdgeInsets.symmetric(horizontal: context.mediumValue, vertical: context.mediumValue / 1.7),
      suffixIcon: Image.asset(
        Images.filter,
        width: 10,
        fit: BoxFit.cover,
      ).paddingAll(12),
      prefixIcon: prefixIcon,
      controller: searchController,
    );
  }
}
