import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/features/home/view_models/books_by_category_search_state.dart';
import 'package:piton/models/book/res/get_products_by_category_id_response.dart';

final booksByCategorySearchViewModelPr =
    AutoDisposeNotifierProvider<BooksByCategorySearchViewModel, BooksByCategorySearchState>(
        BooksByCategorySearchViewModel.new);

class BooksByCategorySearchViewModel extends AutoDisposeNotifier<BooksByCategorySearchState> {
  @override
  BooksByCategorySearchState build() {
    return BooksByCategorySearchState();
  }

  void setSearchStatus(bool isSearching) {
    state = state.copyWith(isSearching: isSearching);
    if (!isSearching) {
      state = state.copyWith(filteredBooks: []);
    }
  }

  void searchBooks(String query) {
    final products = state.books;
    final searchResults =
        products.where((product) => product.name.toString().toLowerCase().contains(query.toLowerCase())).toList();
    state = state.copyWith(filteredBooks: searchResults, isSearching: true);
  }

  void addBooks(List<Product> newProducts) {
    final uniqueResults = [
      ...state.books,
      ...newProducts.where((newProduct) => state.books.every((existingProduct) => existingProduct.id != newProduct.id)),
    ];
    state = state.copyWith(books: uniqueResults);
  }
}
