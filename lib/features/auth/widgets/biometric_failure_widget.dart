import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BiometricFailureWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const BiometricFailureWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 100,
              color: Colors.red,
            ).animate().slideX(),
            const SizedBox(height: 20),
            // Hata mesajı
            const Text(
              'Biyometrik doğrulama başarısız.\nLütfen tekrar deneyin.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),
            // Tekrar deneme butonu
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Tekrar Dene',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
