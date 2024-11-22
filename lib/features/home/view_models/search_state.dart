// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:piton/models/book/res/get_products_by_category_id_response.dart';

class SearchState with EquatableMixin {
  final bool isSearching;
  final List<Product> books;
  final List<Product> filteredBooks;

  SearchState({
    this.isSearching = false,
    this.books = const [],
    this.filteredBooks = const [],
  });

  SearchState copyWith({
    bool? isSearching,
    List<Product>? books,
    List<Product>? filteredBooks,
  }) {
    return SearchState(
      isSearching: isSearching ?? this.isSearching,
      books: books ?? this.books,
      filteredBooks: filteredBooks ?? this.filteredBooks,
    );
  }

  @override
  List<Object?> get props => [isSearching, books, filteredBooks];

  @override
  bool get stringify => true;
}
