extension ValidationExtensions on String {
  // E-mail validation
  String? validateEmail() {
    if (isEmpty) {
      return "E-mail cannot be empty";
    }
    final emailRegex = RegExp(r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$");
    if (!emailRegex.hasMatch(this)) {
      return "Enter a valid e-mail address";
    }
    return null;
  }

  // Password validation
  String? validatePassword() {
    if (isEmpty) {
      return "Password cannot be empty";
    }
    if (length < 6 || length > 20) {
      return "Password must be between 6 and 20 characters";
    }
    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(this)) {
      return "Password must be alphanumeric";
    }
    return null;
  }
}

extension StringValidationExtension on String? {
  /// Checks if the string is not null and not empty.
  bool get notNullOrEmpty => this != null && this!.isNotEmpty;

  /// Checks if the string is null or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
