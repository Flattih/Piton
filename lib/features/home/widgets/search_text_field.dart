import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/core/common/app_text_field.dart';
import 'package:piton/core/constants/image_constants.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/core/extension/padding_extension.dart';
import 'package:piton/features/home/view_models/search_view_model.dart';

class SearchTextField extends ConsumerWidget {
  const SearchTextField({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchViewModelPr);
    return AppTextField(
      onChanged: (value) {
        if (value.isEmpty) {
          ref.read(searchViewModelPr.notifier).setSearchStatus(false);
        }
      },
      onSubmitted: (value) {
        ref.read(searchViewModelPr.notifier).searchBooks(value);
      },
      contentPadding: EdgeInsets.symmetric(horizontal: context.mediumValue, vertical: context.mediumValue / 1.7),
      suffixIcon: Image.asset(
        Images.filter,
        width: 10,
        fit: BoxFit.cover,
      ).paddingAll(12),
      prefixIcon: Consumer(
        builder: (context, ref, child) {
          final isSearching = searchState.isSearching;

          return IconButton(
            onPressed: () {
              if (isSearching) {
                searchController.clear();
                ref.read(searchViewModelPr.notifier).setSearchStatus(false);
              }
            },
            icon: Icon(isSearching ? Icons.close : Icons.search),
            color: isSearching ? Colors.red : const Color(0xFF9696AF),
          );
        },
      ),
      controller: searchController,
    );
  }
}
