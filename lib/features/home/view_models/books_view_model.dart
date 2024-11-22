import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/features/home/repository/book_repository.dart';
import 'package:piton/features/home/view_models/search_view_model.dart';
import 'package:piton/models/book/res/get_products_by_category_id_response.dart';

final booksViewModelPr = AutoDisposeAsyncNotifierProvider<BooksViewModel, List<Product>>(BooksViewModel.new);

class BooksViewModel extends AutoDisposeAsyncNotifier<List<Product>> {
  @override
  FutureOr<List<Product>> build() async {
    return [];
  }

  Future<void> getBooksByCategoryId(int categoryId) async {
    try {
      state = const AsyncLoading();
      final books = await ref.read(bookRepositoryProvider).getBooksByCategoryId(categoryId);
      ref.read(searchViewModelPr.notifier).addBooks(books);
      state = AsyncData(books);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
