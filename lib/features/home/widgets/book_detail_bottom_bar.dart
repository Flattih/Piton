import 'package:flutter/material.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/core/extension/padding_extension.dart';
import 'package:piton/core/theme/app_colors.dart';
import 'package:piton/models/book/res/get_product_by_id_response.dart';

class BookDetailBottomBar extends StatelessWidget {
  final ProductByPk book;
  const BookDetailBottomBar({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        width: context.width,
        decoration: BoxDecoration(
          color: AppColors.orangeColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${book.price} \$",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              "Buy Now",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 22),
      ),
    );
  }
}
