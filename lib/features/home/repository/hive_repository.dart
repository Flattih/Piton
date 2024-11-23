import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:piton/models/book/res/get_book_categories_response.dart';
import 'package:piton/models/book/res/get_products_by_category_id_response.dart';

/// Provides a singleton instance of [HiveRepository]
final hiveRepositoryProvider = Provider.autoDispose<HiveRepository>((ref) => HiveRepository());

/// Repository class for handling local cache operations using Hive
///
/// This repository manages caching of book categories and products with automatic
/// cache expiration after 24 hours.
class HiveRepository {
  // Box name constants
  static const String _categoriesBoxName = 'categories';
  static const String _booksBoxName = 'books';

  // Cache key constants
  static const String _cacheExpirationKey = 'cache_expiration';
  static const Duration _cacheExpiration = Duration(days: 1);

  /// Creates a cache key for books by category
  String _createBooksCacheKey(int categoryId) => 'books_$categoryId';

  /// Creates an expiration key for books by category
  String _createBooksExpirationKey(int categoryId) => 'cache_expiration_$categoryId';

  /// Calculates the expiration timestamp for cache entries
  int _calculateExpirationTime() => DateTime.now().add(_cacheExpiration).millisecondsSinceEpoch;

  /// Saves book categories to local cache with expiration
  ///
  /// [bookCategories] List of [BookCategory] objects to cache
  Future<void> saveBookCategoriesToCache(List<BookCategory> bookCategories) async {
    final categoriesBox = Hive.box(name: _categoriesBoxName);

    // Clear existing data before saving new categories
    categoriesBox.clear();

    // Save each category with an indexed key
    for (var i = 0; i < bookCategories.length; i++) {
      categoriesBox.put(
        '$_categoriesBoxName - $i',
        bookCategories[i].toJson(),
      );
    }

    // Set cache expiration
    categoriesBox.put(_cacheExpirationKey, _calculateExpirationTime());
  }

  /// Saves books for a specific category to local cache
  ///
  /// [categoryId] The ID of the category these books belong to
  /// [books] List of [Product] objects to cache
  Future<void> saveBooksToCache(int categoryId, List<Product> books) async {
    final booksBox = Hive.box(name: _booksBoxName);

    // Save books with category-specific key
    booksBox.put(
      _createBooksCacheKey(categoryId),
      books.map((book) => book.toJson()).toList(),
    );

    // Set cache expiration for this category
    booksBox.put(
      _createBooksExpirationKey(categoryId),
      _calculateExpirationTime(),
    );
  }

  /// Retrieves books for a specific category from cache if available and valid
  ///
  /// [categoryId] The ID of the category to fetch books for
  /// [ref] Riverpod reference for state management
  ///
  /// Returns an empty list if cache is expired or no data is found
  List<Product> getBooksFromCache(int categoryId, Ref ref) {
    final booksBox = Hive.box(name: _booksBoxName);
    final expirationTime = booksBox.get(_createBooksExpirationKey(categoryId)) as int?;

    // Check if cache is still valid
    if (expirationTime != null && DateTime.now().millisecondsSinceEpoch < expirationTime) {
      final booksJson = booksBox.get(_createBooksCacheKey(categoryId)) as List?;

      if (booksJson != null && booksJson.isNotEmpty) {
        return booksJson.map((bookJson) => Product.fromJson(bookJson)).toList();
      }
    } else {
      // Clean up expired cache
      _cleanupExpiredBooksCache(booksBox, categoryId);
    }

    return [];
  }

  /// Retrieves book categories from cache if available and valid
  ///
  /// Returns an empty list if cache is expired or no data is found
  List<BookCategory> getBookCategoriesFromCache() {
    final categoriesBox = Hive.box(name: _categoriesBoxName);
    final expirationTime = categoriesBox.get(_cacheExpirationKey) as int?;

    // Check if cache is still valid
    if (expirationTime != null && DateTime.now().millisecondsSinceEpoch < expirationTime) {
      final categories = <BookCategory>[];

      // Retrieve all cached categories
      for (var i = 0; i < categoriesBox.length - 1; i++) {
        final categoryJson = categoriesBox.get('$_categoriesBoxName - $i');
        if (categoryJson != null) {
          categories.add(BookCategory.fromJson(categoryJson));
        }
      }

      return categories;
    } else {
      // Clean up expired cache
      categoriesBox.clear();
    }

    return [];
  }

  /// Cleans up expired books cache for a specific category
  void _cleanupExpiredBooksCache(Box booksBox, int categoryId) {
    booksBox.delete(_createBooksCacheKey(categoryId));
    booksBox.delete(_createBooksExpirationKey(categoryId));
  }
}
