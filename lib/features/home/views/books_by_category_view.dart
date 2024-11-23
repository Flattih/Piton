import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:piton/core/common/app_loader.dart';
import 'package:piton/core/extension/padding_extension.dart';
import 'package:piton/core/extension/widget_extension.dart';
import 'package:piton/features/home/mixin/products_by_category_view_mixin.dart';
import 'package:piton/features/home/view_models/books_by_category_view_model.dart';
import 'package:piton/features/home/view_models/books_by_category_search_view_model.dart';
import 'package:piton/features/home/widgets/book_grid_item.dart';
import 'package:piton/features/home/widgets/custom_sliver_app_bar.dart';
import 'package:piton/features/home/widgets/search_text_field.dart';
import 'package:piton/features/home/widgets/search_tile.dart';
import 'package:piton/models/book/res/get_book_categories_response.dart';

class BooksByCategoryView extends ConsumerStatefulWidget {
  final BookCategory bookCategory;
  static const routeName = '/get-products-by-category';
  const BooksByCategoryView({super.key, required this.bookCategory});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GetProductsByCategoryViewState();
}

class _GetProductsByCategoryViewState extends ConsumerState<BooksByCategoryView> with ProductsByCategoryViewMixin {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(booksByCategoryViewModelPr.notifier).getBooksByCategoryId(widget.bookCategory.id ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(booksByCategorySearchViewModelPr);
    final productsByCategorySearchViewModel = ref.read(booksByCategorySearchViewModelPr.notifier);
    final books = ref.watch(booksByCategoryViewModelPr);

    final isLoading = ref.watch(isLoadingProvider);
    return isLoading
        ? const LoadingView()
        : Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  CustomSliverAppBar(
                    text: widget.bookCategory.name ?? "Kategori İsmi",
                  ),
                  const SliverGap(20),
                  SearchTextField(
                    searchController: searchController,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        productsByCategorySearchViewModel.setSearchStatus(false);
                      }
                    },
                    onSubmitted: (value) {
                      productsByCategorySearchViewModel.searchBooks(value);
                    },
                    prefixIcon: const Icon(Icons.search),
                  ).paddingSymmetric(horizontal: 12).toSliver,
                  searchState.isSearching
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final book = searchState.filteredBooks[index];
                              return SearchTile(book: book);
                            },
                            childCount: searchState.filteredBooks.length,
                          ),
                        )
                      : SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                          sliver: SliverGrid.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.58,
                            ),
                            itemBuilder: (context, index) {
                              final book = books[index];
                              return BookGridItem(book: book);
                            },
                            itemCount: books.length,
                          ),
                        )
                ],
              ),
            ),
          );
  }
}
