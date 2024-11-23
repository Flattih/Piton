import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/core/constants/api_constants.dart';
import 'package:piton/core/network/dio_client.dart';
import 'package:piton/features/home/repository/hive_repository.dart';
import 'package:piton/models/book/res/get_book_categories_response.dart';
import 'package:piton/models/book/res/get_image_of_book_response.dart';
import 'package:piton/models/book/res/get_product_by_id_response.dart';
import 'package:piton/models/book/res/get_products_by_category_id_response.dart';

// Provider for BookRepository
// Creates BookRepository using Dio instance from DioClient
final bookRepositoryProvider =
    Provider.autoDispose<BookRepository>((ref) => BookRepository(ref.read(dioClientProvider).dio));

// Provider to fetch book categories
// First checks cache, if not available, fetches from the API
final getBookCategoriesProvider = FutureProvider.autoDispose<List<BookCategory>>((ref) async {
  final cachedCategories = ref.read(hiveRepositoryProvider).getBookCategoriesFromCache();

  // Return cached categories if available
  if (cachedCategories.isNotEmpty) {
    return cachedCategories;
  }

  // Fetch categories from API and save to cache
  final categories = await ref.read(bookRepositoryProvider).getBookCategories();
  await ref.read(hiveRepositoryProvider).saveBookCategoriesToCache(categories);
  return categories;
});

// Provider to fetch the image URL of a book by file name
final getImageOfBookProvider = FutureProvider.autoDispose.family<String, String>((ref, fileName) async {
  return ref.read(bookRepositoryProvider).getImageOfBook(fileName);
});

// Provider to fetch books by category ID
// Checks cache first, otherwise fetches from the API
final getBooksByCategoryIdProvider = FutureProvider.autoDispose.family<List<Product>, int>((ref, categoryId) async {
  final cachedBooks = ref.read(hiveRepositoryProvider).getBooksFromCache(categoryId, ref);

  // Return cached books if available
  if (cachedBooks.isNotEmpty) {
    return cachedBooks;
  }

  // Fetch books from API and save to cache
  final books = await ref.read(bookRepositoryProvider).getBooksByCategoryId(categoryId);
  await ref.read(hiveRepositoryProvider).saveBooksToCache(categoryId, books);
  return books;
});

// Repository to handle all book-related API calls
class BookRepository {
  final Dio _dio;

  BookRepository(this._dio);

  // Fetch book categories from API
  Future<List<BookCategory>> getBookCategories() async {
    try {
      final response = await _dio.get(ApiConstants.GET_CATEGORIES_URL);
      return GetBookCategoriesResponse.fromJson(response.data).category ?? [];
    } on DioException catch (e) {
      return Future.error(e.message ?? ApiConstants.DEFAULT_ERROR_MESSAGE);
    }
  }

  // Fetch books by category ID from API
  Future<List<Product>> getBooksByCategoryId(int categoryId) async {
    try {
      final response = await _dio.get('${ApiConstants.GET_BOOKS_BY_CATEGORY_ID_URL}/$categoryId');
      return GetProductsByCategoryIdResponse.fromJson(response.data).product ?? [];
    } on DioException catch (e) {
      return Future.error(e.message ?? ApiConstants.DEFAULT_ERROR_MESSAGE);
    }
  }

  // Fetch book details by product ID from API
  Future<ProductByPk> getBookById(int productId) async {
    try {
      final response = await _dio.get('${ApiConstants.GET_BOOK_BY_ID_URL}/$productId');
      return GetProductByIdResponse.fromJson(response.data).productByPk ?? ProductByPk();
    } on DioException catch (e) {
      return Future.error(e.message ?? ApiConstants.DEFAULT_ERROR_MESSAGE);
    }
  }

  // Add a book to the user's favorites
  Future<void> likeBook(int productId, String userId) async {
    try {
      await _dio.post(
        ApiConstants.LIKE_BOOK_URL,
      );
    } on DioException catch (e) {
      return Future.error(e.message ?? ApiConstants.DEFAULT_ERROR_MESSAGE);
    }
  }

  // Remove a book from the user's favorites
  Future<void> unlikeBook(int productId, String userId) async {
    try {
      await _dio.post(
        ApiConstants.UNLIKE_BOOK_URL,
      );
    } on DioException catch (e) {
      return Future.error(e.message ?? ApiConstants.DEFAULT_ERROR_MESSAGE);
    }
  }

  // Fetch the image URL of a book from the API
  Future<String> getImageOfBook(String fileName) async {
    try {
      final response = await _dio.post(ApiConstants.GET_IMAGE_OF_BOOK_URL, data: {'fileName': fileName});
      return GetImageOfBookResponse.fromJson(response.data).actionProductImage?.url ?? ApiConstants.DEFAULT_BOOK_PIC;
    } on DioException catch (e) {
      return Future.error(e.message ?? ApiConstants.DEFAULT_ERROR_MESSAGE);
    }
  }
}
