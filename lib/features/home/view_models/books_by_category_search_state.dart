import 'package:equatable/equatable.dart';
import 'package:piton/models/book/res/get_products_by_category_id_response.dart';

class BooksByCategorySearchState with EquatableMixin {
  final bool isSearching;
  final List<Product> books;
  final List<Product> filteredBooks;

  BooksByCategorySearchState({
    this.isSearching = false,
    this.books = const [],
    this.filteredBooks = const [],
  });

  BooksByCategorySearchState copyWith({
    bool? isSearching,
    List<Product>? books,
    List<Product>? filteredBooks,
  }) {
    return BooksByCategorySearchState(
      isSearching: isSearching ?? this.isSearching,
      books: books ?? this.books,
      filteredBooks: filteredBooks ?? this.filteredBooks,
    );
  }

  @override
  List<Object?> get props => [isSearching, books, filteredBooks];
}
