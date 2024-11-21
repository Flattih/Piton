import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/app_startup.dart';
import 'package:piton/core/extension/string_extension.dart';

class SharedPref {
  SharedPref._();

  static const String token = "token";
  static const String theme = 'theme';
  static const String onboarding = 'onboarding';

  // Give token is not null or not empty
  static bool isTokenExist(WidgetRef ref) {
    final token = ref.read(sharedPreferencesProvider).requireValue.getString(SharedPref.token);
    return token.notNullOrEmpty;
  }

  // Save token
  static Future<void> saveToken(Ref ref, String token) async {
    await ref.read(sharedPreferencesProvider).requireValue.setString(SharedPref.token, token);
  }

  // Remove token
  static Future<void> removeToken(WidgetRef ref) async {
    await ref.read(sharedPreferencesProvider).requireValue.remove(SharedPref.token);
  }
}
