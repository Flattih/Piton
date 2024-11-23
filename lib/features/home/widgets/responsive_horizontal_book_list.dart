import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:piton/core/common/app_loader.dart';
import 'package:piton/core/common/app_network_image.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/core/extension/padding_extension.dart';
import 'package:piton/core/theme/app_colors.dart';
import 'package:piton/features/home/repository/book_repository.dart';
import 'package:piton/features/home/view_models/home_search_view_model.dart';
import 'package:piton/features/home/views/book_detail_view.dart';
import 'package:piton/features/home/views/books_by_category_view.dart';
import 'package:piton/features/home/widgets/section_header.dart';
import 'package:piton/models/book/res/get_book_categories_response.dart';
import 'package:piton/models/book/res/get_products_by_category_id_response.dart';

class ResponsiveHorizontalBookList extends ConsumerWidget {
  final BookCategory bookCategory;

  const ResponsiveHorizontalBookList({super.key, required this.bookCategory});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Kart boyutları
    final double cardWidth = context.width * 0.6;
    final double cardHeight = context.height * 0.2;

    // Kitapları dinle
    final booksAsyncValue = ref.watch(getBooksByCategoryIdProvider(bookCategory.id ?? 2));

    // FutureProvider tamamlandığında cache verisini searchViewModel'a ekle
    ref.listen<AsyncValue<List<Product>>>(
      getBooksByCategoryIdProvider(bookCategory.id ?? 2),
      (previous, next) {
        if (next is AsyncData<List<Product>> && previous != next) {
          final cachedBooks = next.value;
          ref.read(homeSearchViewModelPr.notifier).addBooks(cachedBooks);
        }
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bölüm başlığı
        SectionHeader(
          title: bookCategory.name ?? "",
          onTapViewAll: () {
            context.toNamed(
              BooksByCategoryView.routeName,
              arguments: bookCategory,
            );
          },
        ),
        const Gap(20),

        // İçeriğe göre kitap listesi
        booksAsyncValue.when(
          data: (books) {
            if (books.isEmpty) {
              return Center(
                child: Text(
                  "No books available.",
                  style: TextStyle(
                    color: AppColors.purpleColor,
                    fontSize: cardWidth * 0.05,
                  ),
                ),
              );
            }

            return SizedBox(
              height: cardHeight,
              child: ListView.builder(
                itemCount: books.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final book = books[index];
                  return _buildBookCard(context, cardWidth, cardHeight, book);
                },
              ),
            );
          },
          loading: () => const Loader(), // Yükleniyor göstergesi
          error: (error, stackTrace) {
            return ErrorHandler(
              errorMessage: error.toString(),
              onRetry: () {
                ref.invalidate(getBooksByCategoryIdProvider(bookCategory.id ?? 2));
              },
            );
          },
        ),
      ],
    ).paddingOnly(bottom: 30);
  }

  // Kitap kartı widget'ı
  Widget _buildBookCard(
    BuildContext context,
    double cardWidth,
    double cardHeight,
    Product book,
  ) {
    return GestureDetector(
      onTap: () {
        context.toNamed(BookDetailView.routeName, arguments: book.id);
      },
      child: Container(
        width: cardWidth,
        margin: EdgeInsets.only(right: context.lowValue * 2),
        decoration: BoxDecoration(
          color: context.primaryColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // Kitap resmi
            AppNetworkImage(
              borderRadius: BorderRadius.circular(12),
              size: Size(cardWidth * 0.4, cardHeight),
              fileName: book.cover,
            ),

            const Gap(8),

            // Kitap bilgileri
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    book.name ?? "",
                    style: TextStyle(
                      fontSize: cardWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.author ?? "",
                    style: TextStyle(
                      fontSize: cardWidth * 0.047,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF676787),
                    ),
                  ),
                  const Spacer(flex: 4),
                  Text(
                    "${book.price} \$",
                    style: TextStyle(
                      fontSize: cardWidth * 0.065,
                      fontWeight: FontWeight.bold,
                      color: AppColors.purpleColor,
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
