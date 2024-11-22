import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/core/constants/api_constants.dart';
import 'package:piton/core/network/dio_client.dart';
import 'package:piton/features/home/repository/hive_repository.dart';
import 'package:piton/models/book/res/get_book_categories_response.dart';
import 'package:piton/models/book/res/get_image_of_book_response.dart';
import 'package:piton/models/book/res/get_products_by_category_id_response.dart';

final bookRepositoryProvider =
    Provider.autoDispose<BookRepository>((ref) => BookRepository(ref.read(dioClientProvider).dio));

final getBookCategoriesProvider = FutureProvider.autoDispose<List<BookCategory>>((ref) async {
  final cachedCategories = ref.read(hiveRepositoryProvider).getBookCategoriesFromCache();

  if (cachedCategories.isNotEmpty) {
    return cachedCategories;
  }
  final categories = await ref.read(bookRepositoryProvider).getBookCategories();
  await ref.read(hiveRepositoryProvider).saveBookCategoriesToCache(categories);
  return categories;
});

final getImageOfBookProvider = FutureProvider.autoDispose.family<String, String>((ref, fileName) async {
  return ref.read(bookRepositoryProvider).getImageOfBook(fileName);
});

final getBooksByCategoryIdProvider = FutureProvider.autoDispose.family<List<Product>, int>((ref, categoryId) async {
  final cachedBooks = ref.read(hiveRepositoryProvider).getBooksFromCache(categoryId, ref);

  if (cachedBooks.isNotEmpty) {
    return cachedBooks;
  }

  final books = await ref.read(bookRepositoryProvider).getBooksByCategoryId(categoryId);

  await ref.read(hiveRepositoryProvider).saveBooksToCache(categoryId, books);

  return books;
});

class BookRepository {
  final Dio _dio;

  BookRepository(this._dio);
  Future<List<BookCategory>> getBookCategories() async {
    try {
      final response = await _dio.get(ApiConstants.GET_CATEGORIES_URL);
      return GetBookCategoriesResponse.fromJson(response.data).category ?? [];
    } on DioException catch (e) {
      return Future.error(e.message ?? ApiConstants.DEFAULT_ERROR_MESSAGE);
    }
  }

  Future<List<Product>> getBooksByCategoryId(int categoryId) async {
    try {
      final response = await _dio.get('${ApiConstants.GET_BOOKS_BY_CATEGORY_ID_URL}/$categoryId');
      return GetProductsByCategoryIdResponse.fromJson(response.data).product ?? [];
    } on DioException catch (e) {
      return Future.error(e.message ?? ApiConstants.DEFAULT_ERROR_MESSAGE);
    }
  }

  Future<String> getImageOfBook(String fileName) async {
    try {
      final response = await _dio.post(ApiConstants.GET_IMAGE_OF_BOOK_URL, data: {'fileName': fileName});
      return GetImageOfBookResponse.fromJson(response.data).actionProductImage?.url ?? ApiConstants.DEFAULT_BOOK_PIC;
    } on DioException catch (e) {
      return Future.error(e.message ?? ApiConstants.DEFAULT_ERROR_MESSAGE);
    }
  }
}
