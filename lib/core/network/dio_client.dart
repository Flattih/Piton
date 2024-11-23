import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/app_startup.dart';
import 'package:piton/core/constants/api_constants.dart';
import 'package:piton/core/constants/shared_pref.dart';

final dioProvider = Provider<Dio>((ref) => Dio());
final dioClientProvider = Provider<DioClient>((ref) => DioClient(ref.read(dioProvider), ref));

class DioClient {
  final Dio dio;
  final Ref ref;

  DioClient(this.dio, this.ref) {
    dio.options.baseUrl = ApiConstants.BASE_URL;
    dio.options.connectTimeout = const Duration(seconds: 9);
    dio.options.receiveTimeout = const Duration(seconds: 15);
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = ref.read(sharedPreferencesProvider).requireValue.getString(SharedPref.token);
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
        onError: (e, handler) {
          final errorMessage = e.response?.data?["error"] ?? e.message;
          handler.next(DioException(
            requestOptions: e.requestOptions,
            message: errorMessage,
            response: e.response,
            type: e.type,
          ));
        },
      ),
    );

    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }
}
