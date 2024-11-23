import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:piton/features/home/repository/book_repository.dart';
import 'package:piton/features/home/repository/hive_repository.dart';
import 'package:piton/features/home/view_models/books_by_category_search_view_model.dart';
import 'package:piton/models/book/res/get_products_by_category_id_response.dart';

final booksByCategoryViewModelPr =
    AutoDisposeNotifierProvider<BooksByCategoryViewModel, List<Product>>(BooksByCategoryViewModel.new);

final isLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

class BooksByCategoryViewModel extends AutoDisposeNotifier<List<Product>> {
  Future<void> getBooksByCategoryId(int categoryId) async {
    try {
      ref.read(isLoadingProvider.notifier).update((_) => true);
      final cachedBooks = ref.read(hiveRepositoryProvider).getBooksFromCache(categoryId, ref);
      if (cachedBooks.isNotEmpty) {
        ref.read(booksByCategorySearchViewModelPr.notifier).addBooks(cachedBooks);
        state = cachedBooks;
        return;
      }
      final books = await ref.read(bookRepositoryProvider).getBooksByCategoryId(categoryId);
      ref.read(booksByCategorySearchViewModelPr.notifier).addBooks(books);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      ref.read(isLoadingProvider.notifier).update((_) => false);
    }
  }

  @override
  List<Product> build() {
    return [];
  }
}
