import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/core/constants/shared_pref.dart';
import 'package:piton/features/auth/repository/auth_repository.dart';
import 'package:piton/features/auth/views/sign_in_view.dart';
import 'package:piton/models/auth/req/sign_in_req.dart';
import 'package:piton/models/auth/req/sign_up_req.dart';

final authViewModelPr = AutoDisposeAsyncNotifierProvider<AuthViewModel, void>(AuthViewModel.new);

class AuthViewModel extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<bool> signUpWithEmail(SignUpReq signUpReq) async {
    final authRepository = ref.read(authRepositoryProvider);
    try {
      state = const AsyncLoading();
      await authRepository.signUpWithEmail(signUpReq);
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

  Future<bool> signInWithEmailAndPassword(SignInReq signInReq) async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      final shouldRemember = ref.read(rememberMeProvider);

      state = const AsyncLoading();
      final token = await authRepository.signInWithEmailAndPassword(signInReq);

      if (shouldRemember && token.isNotEmpty) {
        await SharedPref.saveToken(ref, token);
      }
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

/*   Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final userCredential = await authRepository.signInWithEmailAndPassword(email, password);
      final idToken = await userCredential.user?.getIdToken();
      final response = await ref.read(dioClientProvider).dio.post(
            ApiConstants.SIGN_IN_URL,
            data: SignInModel(idToken: idToken ?? "").toJson(),
          );
      ref.read(userProvider.notifier).update((state) => UserModel.fromMap(response.data));
    });
  }
 */
}
