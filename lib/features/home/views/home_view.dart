import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:piton/core/common/app_loader.dart';
import 'package:piton/core/extension/padding_extension.dart';
import 'package:piton/core/extension/widget_extension.dart';
import 'package:piton/features/home/mixin/home_view_mixin.dart';
import 'package:piton/features/home/repository/book_repository.dart';
import 'package:piton/features/home/view_models/home_search_view_model.dart';
import 'package:piton/features/home/widgets/animated_sliver_app_bar.dart';
import 'package:piton/features/home/widgets/responsive_horizontal_book_list.dart';
import 'package:piton/features/home/widgets/search_text_field.dart';
import 'package:piton/features/home/widgets/search_tile.dart';
import 'package:piton/features/home/widgets/top_categories.dart';

class HomeView extends ConsumerStatefulWidget {
  static const String routeName = '/home';
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(homeSearchViewModelPr);
    final homeSearchViewModel = ref.read(homeSearchViewModelPr.notifier);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const AnimatedSliverAppBar(),
            const TopCategories().toSliver,
            const SliverGap(25),
            SearchTextField(
              searchController: searchController,
              onChanged: (value) {
                if (value.isEmpty) {
                  homeSearchViewModel.setSearchStatus(false);
                }
              },
              onSubmitted: (value) {
                homeSearchViewModel.searchBooks(value);
              },
              prefixIcon: Consumer(
                builder: (context, ref, child) {
                  final isSearching = searchState.isSearching;

                  return IconButton(
                    onPressed: () {
                      if (isSearching) {
                        searchController.clear();
                        homeSearchViewModel.setSearchStatus(false);
                      }
                    },
                    icon: Icon(isSearching ? Icons.close : Icons.search),
                    color: isSearching ? Colors.red : const Color(0xFF9696AF),
                  );
                },
              ),
            ).paddingOnly(right: 12).toSliver,
            const SliverGap(40),
            searchState.isSearching
                ? Consumer(builder: (ctx, ref, child) {
                    return SliverList.builder(
                      itemBuilder: (context, index) {
                        final book = searchState.filteredBooks[index];
                        return SearchTile(
                          book: book,
                        );
                      },
                      itemCount: searchState.filteredBooks.length,
                    );
                  })
                : ref.watch(getBookCategoriesProvider).when(
                      data: (bookCategories) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              final bookCategory = bookCategories[index];
                              return ResponsiveHorizontalBookList(
                                bookCategory: bookCategory,
                              );
                            },
                            childCount: bookCategories.length,
                          ),
                        );
                      },
                      error: (error, stackTrace) {
                        return ErrorHandler(
                          errorMessage: error.toString(),
                          onRetry: () {
                            ref.refresh(getBookCategoriesProvider);
                          },
                        ).toSliver;
                      },
                      loading: () => const Loader().toSliver,
                    ),
          ],
        ).paddingOnly(
          left: 16,
        ),
      ),
    );
  }
}
