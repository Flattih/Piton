import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/features/home/repository/book_repository.dart';
import 'package:piton/models/book/res/get_product_by_id_response.dart';

final bookDetailViewModelPr =
    AutoDisposeAsyncNotifierProvider<BookDetailViewModel, ProductByPk>(BookDetailViewModel.new);

class BookDetailViewModel extends AutoDisposeAsyncNotifier<ProductByPk> {
  @override
  FutureOr<ProductByPk> build() async {
    return ProductByPk();
  }

  Future<void> getBookById(int bookId) async {
    try {
      state = const AsyncLoading();
      final book = await ref.read(bookRepositoryProvider).getBookById(bookId);
      state = AsyncData(book);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // Like Book
  Future<void> likeBook(int bookId) async {
    try {
      state = const AsyncLoading();
      await ref.read(bookRepositoryProvider).likeBook(bookId, "userId");
      // If the API were correct, the scenario would be that we need to have a parameter called isLiked to indicate that it is liked, or we need to check if a list contains userId. Then, we would call the like or unlike functions depending on the isLiked status.
      // state = AsyncData(state.requireValue.copyWith(likes: state.requireValue.likes + 1));
      state = AsyncData(state.requireValue);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // Unlike Book
  Future<void> unlikeBook(int bookId) async {
    try {
      state = const AsyncLoading();
      await ref.read(bookRepositoryProvider).unlikeBook(bookId, "userId");
      // If the API were correct, the scenario would be that we need to have a parameter called isLiked to indicate that it is liked, or we need to check if a list contains userId. Then, we would call the like or unlike functions depending on the isLiked status.
      // state = AsyncData(state.requireValue.copyWith(likes: state.requireValue.likes - 1));
      state = AsyncData(state.requireValue);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
