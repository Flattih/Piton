import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Loader(),
    );
  }
}

class ErrorHandler extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;
  const ErrorHandler({super.key, required this.errorMessage, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ErrorButton(onRetry: onRetry),
          ],
        ),
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const ErrorView({super.key, required this.errorMessage, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorMessage,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ErrorButton(onRetry: onRetry),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorButton extends StatelessWidget {
  const ErrorButton({
    super.key,
    required this.onRetry,
  });

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(foregroundColor: Colors.white, fixedSize: const Size(120, 60)),
      onPressed: onRetry,
      child: const Text("Tekrar Dene", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }
}
