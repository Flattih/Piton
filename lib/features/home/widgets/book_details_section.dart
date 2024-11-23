import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/core/common/app_network_image.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/core/extension/widget_extension.dart';
import 'package:piton/core/theme/app_colors.dart';
import 'package:piton/features/home/view_models/book_detail_view_model.dart';
import 'package:piton/models/book/res/get_product_by_id_response.dart';

class BookDetailsSection extends ConsumerWidget {
  final ProductByPk book;
  const BookDetailsSection({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Stack(
        children: [
          // Kitap içeriği
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Kitap Resmi
              Center(
                child: AppNetworkImage(
                  fileName: book.cover ?? "", // Kitap resmi
                  size: const Size(180, 260), // Resim boyutu
                ),
              ),
              const SizedBox(height: 10),

              // Kitap İsmi
              Text(
                book.name ?? "Kitap İsmi",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),

              // Kitap Yazarı
              Text(
                book.author ?? "Yazar Bilgisi",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(
                    0xFF6B6B87,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),

          Positioned(
            top: 0,
            right: 0,
            child: IconButton.filled(
              style: IconButton.styleFrom(
                iconSize: 32,
                backgroundColor: context.primaryColor,
              ),
              onPressed: () {
                ref.read(bookDetailViewModelPr.notifier).unlikeBook(book.id ?? 0);
              },
              icon: const Icon(
                Icons.favorite_border,
              ),
              color: AppColors.purpleColor,
            ),
          ),
        ],
      ),
    ).toSliver;
  }
}
