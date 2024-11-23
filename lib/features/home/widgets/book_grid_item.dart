import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:piton/core/common/app_network_image.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/core/theme/app_colors.dart';
import 'package:piton/features/home/views/book_detail_view.dart';
import 'package:piton/models/book/res/get_products_by_category_id_response.dart';

class BookGridItem extends StatelessWidget {
  const BookGridItem({
    super.key,
    required this.book,
  });

  final Product book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.toNamed(BookDetailView.routeName, arguments: book.id);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: context.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kitap Fotoğrafı (en üstte) ve border radius ile düzgün görüntüleme
            AspectRatio(
              aspectRatio: 0.75,
              child: AppNetworkImage(
                fileName: book.cover ?? "", // Kitap fotoğrafı
              ),
            ),
            // Kitap İsmi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: AutoSizeText(
                book.name ?? "Kitap İsmi",
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 5),
            // Kitap Yazarı ve Fiyatı
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      book.author ?? "Yazar Bilgisi",
                      maxLines: 1,
                      style: context.textTheme.labelMedium
                          ?.copyWith(color: const Color(0xFF676787), fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: AppColors.purpleColor,
                      fontWeight: FontWeight.bold,
                    ),
                    "\$${book.price ?? '0.00'}", // Fiyat bilgisi
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
