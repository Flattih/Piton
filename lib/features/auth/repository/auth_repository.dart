import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:piton/core/constants/api_constants.dart';
import 'package:piton/core/network/dio_client.dart';
import 'package:piton/models/auth/req/sign_in_req.dart';
import 'package:piton/models/auth/req/sign_up_req.dart';
import 'package:piton/models/auth/res/sign_in_response.dart';
import 'package:piton/models/auth/res/sign_up_response.dart';

// Provides an instance of LocalAuthentication for biometric authentication
final localAuthProvider = Provider.autoDispose<LocalAuthentication>(
  (ref) => LocalAuthentication(),
);

// Provides the AuthRepository to manage authentication-related operations
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    dio: ref.read(dioClientProvider).dio,
    localAuthentication: ref.read(localAuthProvider),
  );
});

// Repository for authentication-related operations, including email and biometric authentication
class AuthRepository {
  final Dio _dio; // Dio client for making network requests
  final LocalAuthentication _localAuthentication; // LocalAuthentication instance for biometrics

  AuthRepository({
    required Dio dio,
    required LocalAuthentication localAuthentication,
  })  : _dio = dio,
        _localAuthentication = localAuthentication;

  // Handles sign-up with email and password
  Future<String> signUpWithEmail(SignUpReq signUpReq) async {
    try {
      final response = await _dio.post(ApiConstants.SIGN_UP_URL, data: signUpReq.toJson());

      // Extracts the token from the API response
      final token = SignUpResponse.fromJson(response.data).actionRegister?.token;
      return token ?? ""; // Returns the token or an empty string if null
    } on DioException catch (e) {
      return Future.error(e.message ?? ApiConstants.DEFAULT_ERROR_MESSAGE);
    }
  }

  // Handles sign-in with email and password
  Future<String> signInWithEmailAndPassword(SignInReq signInReq) async {
    try {
      final response = await _dio.post(ApiConstants.SIGN_IN_URL, data: signInReq.toJson());

      // Extracts the token from the API response
      final token = SignInResponse.fromJson(response.data).actionLogin?.token;
      return token ?? ""; // Returns the token or an empty string if null
    } on DioException catch (e) {
      return Future.error(e.message ?? ApiConstants.DEFAULT_ERROR_MESSAGE);
    }
  }

  // Performs biometric authentication
  Future<bool> authenticateWithBiometrics() async {
    try {
      // Checks if biometric authentication is available
      final isAvailable = await _localAuthentication.canCheckBiometrics;

      if (isAvailable) {
        // Prompts the user for biometric authentication
        final isAuthenticated = await _localAuthentication.authenticate(
          localizedReason: "Biometric authentication is required to continue", // Prompt message
          options: const AuthenticationOptions(
            stickyAuth: true,
            useErrorDialogs: true,
          ),
        );
        return isAuthenticated; // Returns true if authentication is successful
      }
      return false; // Returns false if biometric authentication is not available
    } catch (e) {
      return false;
    }
  }
}
