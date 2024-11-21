import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/core/constants/api_constants.dart';
import 'package:piton/core/constants/shared_pref.dart';
import 'package:piton/core/network/dio_client.dart';
import 'package:piton/models/auth/req/sign_in_req.dart';
import 'package:piton/models/auth/req/sign_up_req.dart';
import 'package:piton/models/auth/res/sign_in_response.dart';
import 'package:piton/models/auth/res/sign_up_response.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    dio: ref.read(dioClientProvider).dio,
  );
});

class AuthRepository {
  final Dio _dio;

  AuthRepository({
    required Dio dio,
  }) : _dio = dio;

  Future<String> signUpWithEmail(SignUpReq signUpReq) async {
    try {
      final response = await _dio.post(ApiConstants.SIGN_UP_URL, data: signUpReq.toJson());
      final token = SignUpResponse.fromJson(response.data).actionRegister?.token;
      return token ?? "";
    } on DioException catch (e) {
      return Future.error(e.message ?? ApiConstants.DEFAULT_ERROR_MESSAGE);
    }
  }

  Future<String> signInWithEmailAndPassword(SignInReq signInReq) async {
    try {
      final response = await _dio.post(ApiConstants.SIGN_IN_URL, data: signInReq.toJson());
      final token = SignInResponse.fromJson(response.data).actionLogin?.token;
      return token ?? "";
    } on DioException catch (e) {
      return Future.error(e.message ?? ApiConstants.DEFAULT_ERROR_MESSAGE);
    }
  }
}
