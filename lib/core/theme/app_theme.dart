import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/app_startup.dart';
import 'package:piton/core/constants/shared_pref.dart';
import 'package:piton/core/theme/app_colors.dart';

final themeProvider = StateNotifierProvider<AppTheme, ThemeData>((ref) {
  return AppTheme(ref: ref);
});

class AppTheme extends StateNotifier<ThemeData> {
  final Ref ref;
  AppTheme({required this.ref}) : super(lightTheme) {
    getTheme();
  }

  static ThemeData lightTheme = ThemeData(
      fontFamily: "Manrope",
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.purpleColor),
        ),
      ),
      checkboxTheme: const CheckboxThemeData(
        side: BorderSide(color: AppColors.purpleColor, width: 2),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(double.infinity, 60),
          foregroundColor: Colors.white,
          backgroundColor: AppColors.orangeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: AppColors.primaryColor);
  static ThemeData darkTheme = ThemeData.dark();

  void getTheme() {
    final theme = ref.read(sharedPreferencesProvider).requireValue.getString(SharedPref.theme);

    if (theme == ThemeMode.dark.name) {
      state = darkTheme;
    } else {
      state = lightTheme;
    }
  }

  void toggleTheme() async {
    if (state == darkTheme) {
      await ref.read(sharedPreferencesProvider).requireValue.setString(SharedPref.theme, ThemeMode.light.name);
      state = lightTheme;
    } else {
      await ref.read(sharedPreferencesProvider).requireValue.setString(SharedPref.theme, ThemeMode.dark.name);
      state = darkTheme;
    }
  }
}
