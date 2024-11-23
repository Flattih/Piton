import 'package:flutter/material.dart';
import 'package:piton/core/common/app_network_image.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/features/home/views/book_detail_view.dart';
import 'package:piton/models/book/res/get_products_by_category_id_response.dart';

class SearchTile extends StatelessWidget {
  const SearchTile({
    super.key,
    required this.book,
  });

  final Product book;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.toNamed(BookDetailView.routeName, arguments: book.id);
      },
      leading: SizedBox(
        width: 65,
        child: AppNetworkImage(
          fileName: book.cover ?? "",
        ),
      ),
      title: Text(book.name ?? ""),
      subtitle: Text(book.author ?? ""),
    );
  }
}
