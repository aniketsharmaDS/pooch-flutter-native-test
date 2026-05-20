class Validators {
  const Validators._();

  static String? required(String? value, String field) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (required(value, 'Email') != null) {
      return 'Email is required';
    }
    final RegExp regExp = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regExp.hasMatch(value!.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? password(String? value) {
    if (required(value, 'Password') != null) {
      return 'Password is required';
    }
    if (value!.length < 6) {
      return 'Minimum 6 characters required';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (required(value, 'Confirm password') != null) {
      return 'Confirm password is required';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String capitalize(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return trimmed;
    if (trimmed.length == 1) return trimmed.toUpperCase();
    return '${trimmed[0].toUpperCase()}${trimmed.substring(1).toLowerCase()}';
  }
}
