import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:piton/models/book/res/get_book_categories_response.dart';
import 'package:piton/models/book/res/get_products_by_category_id_response.dart';

final hiveRepositoryProvider = Provider.autoDispose<HiveRepository>((ref) => HiveRepository());

class HiveRepository {
  // Box names
  final _categoriesBoxName = 'categories';
  final _booksBoxName = 'books';

  // Cache Expiration Key
  final _cacheExpirationKey = 'cache_expiration';

  // Kategori listelerini cache'e kaydet
  Future<void> saveBookCategoriesToCache(List<BookCategory> bookCategories) async {
    final categoriesBox = Hive.box(name: _categoriesBoxName);
    categoriesBox.clear();
    for (var i = 0; i < bookCategories.length; i++) {
      categoriesBox.put("$_categoriesBoxName - ${i.toString()}", bookCategories[i].toJson());
    }
    final expirationTime = DateTime.now().add(const Duration(seconds: 30)).millisecondsSinceEpoch;
    categoriesBox.put(_cacheExpirationKey, expirationTime);
  }

  // Kitapları kategori ID'ye göre cache'e kaydet
  Future<void> saveBooksToCache(int categoryId, List<Product> books) async {
    final booksBox = Hive.box(name: _booksBoxName);
    // Kategoriye özgü kitapları kaydetmek için kategori ID'sini anahtar olarak kullanıyoruz
    booksBox.put("books_$categoryId", books.map((book) => book.toJson()).toList());

    // Cache için expiration time ekle
    final expirationTime = DateTime.now().add(const Duration(seconds: 30)).millisecondsSinceEpoch;
    booksBox.put("cache_expiration_$categoryId", expirationTime);
  }

  // Kategori ID'sine göre kitapları cache'den al
  List<Product> getBooksFromCache(int categoryId, Ref ref) {
    final booksBox = Hive.box(name: _booksBoxName);
    final expirationTime = booksBox.get("cache_expiration_$categoryId") as int?;

    if (expirationTime != null && DateTime.now().millisecondsSinceEpoch < expirationTime) {
      final booksJson = booksBox.get("books_$categoryId") as List?;

      if (booksJson != null && booksJson.isNotEmpty) {
        final cachedBooks = booksJson.map((bookJson) => Product.fromJson(bookJson)).toList();
        return cachedBooks;
      } else {
        return [];
      }
    } else {
      // Cache süresi dolmuşsa veya cache'de veri yoksa temizle
      booksBox.delete("books_$categoryId");
      booksBox.delete("cache_expiration_$categoryId");
      return [];
    }
  }

  // Kategorileri cache'den al
  List<BookCategory> getBookCategoriesFromCache() {
    final categoriesBox = Hive.box(name: _categoriesBoxName);
    final expirationTime = categoriesBox.get(_cacheExpirationKey) as int?;

    if (expirationTime != null && DateTime.now().millisecondsSinceEpoch < expirationTime) {
      final categories = <BookCategory>[];
      for (var i = 0; i < categoriesBox.length - 1; i++) {
        categories.add(BookCategory.fromJson(categoriesBox.get("$_categoriesBoxName - ${i.toString()}")));
      }
      return categories;
    } else {
      // Cache süresi dolmuşsa temizle
      categoriesBox.clear();
      return [];
    }
  }
}
