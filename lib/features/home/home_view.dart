import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:piton/core/common/app_loader.dart';
import 'package:piton/core/common/app_network_image.dart';
import 'package:piton/core/constants/api_constants.dart';
import 'package:piton/core/extension/padding_extension.dart';
import 'package:piton/core/extension/widget_extension.dart';
import 'package:piton/features/home/mixin/home_view_mixin.dart';
import 'package:piton/features/home/repository/book_repository.dart';
import 'package:piton/features/home/view_models/search_view_model.dart';
import 'package:piton/features/home/widgets/custom_sliver_app_bar.dart';
import 'package:piton/features/home/widgets/responsive_horizontal_book_list.dart';
import 'package:piton/features/home/widgets/search_text_field.dart';
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
    final searchState = ref.watch(searchViewModelPr);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const CustomSliverAppBar(),
            const TopCategories().toSliver,
            const SliverGap(25),
            SearchTextField(searchController: searchController).paddingOnly(right: 12).toSliver,
            const SliverGap(40),
            searchState.isSearching
                ? Consumer(builder: (ctx, ref, child) {
                    return SliverList.builder(
                      itemBuilder: (context, index) {
                        final book = searchState.filteredBooks[index];
                        return ListTile(
                          leading: SizedBox(
                            width: 50,
                            child: AppNetworkImage(
                              fileName: book.cover ?? ApiConstants.DEFAULT_BOOK_PIC,
                            ),
                          ),
                          title: Text(book.name ?? ""),
                          subtitle: Text(book.author ?? ""),
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
