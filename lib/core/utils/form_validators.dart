/// Form Validators utility class
/// Provides a collection of reusable form validation methods for common use cases
/// Each validator can be used directly in form fields and customized as needed
class FormValidators {
  /// Validates that a field is not empty
  /// [value] - The input value to validate
  /// [fieldName] - The name of the field for the error message
  /// Returns error message if invalid, null if valid
  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  /// Validates email format
  /// [value] - The email to validate
  /// Returns error message if invalid, null if valid
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }

    const emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    if (!RegExp(emailRegex).hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Validates password strength
  /// [value] - The password to validate
  /// [minLength] - Minimum password length (default: 8)
  /// [requireUppercase] - Require uppercase letters (default: true)
  /// [requireNumbers] - Require numbers (default: true)
  /// [requireSpecialChars] - Require special characters (default: false)
  /// Returns error message if invalid, null if valid
  static String? password(
    String? value, {
    int minLength = 8,
    bool requireUppercase = true,
    bool requireNumbers = true,
    bool requireSpecialChars = false,
  }) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }

    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain uppercase letters';
    }

    if (requireNumbers && !value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain numbers';
    }

    if (requireSpecialChars &&
        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain special characters';
    }

    return null;
  }

  /// Validates that two fields match (e.g., password confirmation)
  /// [value] - The field value
  /// [matchValue] - The value to match against
  /// [fieldName] - The name of the field for the error message
  /// Returns error message if invalid, null if valid
  static String? match(
    String? value,
    String? matchValue, {
    String fieldName = 'Field',
  }) {
    if (value == null || matchValue == null || value != matchValue) {
      return '$fieldName does not match';
    }
    return null;
  }

  /// Validates phone number format
  /// [value] - The phone number to validate
  /// Returns error message if invalid, null if valid
  ///
  /// Uses a normalized, digit-count-based check (E.164 compatible):
  /// - Optional leading '+' allowed
  /// - Digits only after optional '+'
  /// - Accepts between 7 and 15 digits (covers most national and international numbers)
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    }

    // Normalize: remove spaces, dashes, parentheses
    final normalized = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Allow optional leading '+' then digits only
    final hasPlus = normalized.startsWith('+');
    final digits = hasPlus ? normalized.substring(1) : normalized;

    // Must be digits only
    if (!RegExp(r'^\d+$').hasMatch(digits)) {
      return 'Please enter a valid phone number';
    }

    // Accept national/international numbers with reasonable length
    if (digits.length < 7 || digits.length > 15) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  static String? validatePincode(String? value) {
    // 1. Check if empty
    if (value == null || value.isEmpty) {
      return 'Please enter a pincode';
    }

    // 2. Check for numeric characters only
    final numericRegex = RegExp(r'^[0-9]+$');
    if (!numericRegex.hasMatch(value)) {
      return 'Pincode must contain only numbers';
    }

    // 3. Check length (Change '6' to '5' if targeting the US)
    if (value.length != 6) {
      return 'Pincode must be exactly 6 digits';
    }

    return null; // Return null if the input is valid
  }

  /// Validates numeric values with optional min and max bounds
  /// [value] - The numeric string to validate
  /// [fieldName] - The name of the field for error messages
  /// [min] - Minimum allowed value (optional)
  /// [max] - Maximum allowed value (optional)
  /// [allowDecimal] - Allow decimal values (default: true)
  /// [unit] - Unit name for error messages (optional)
  /// Returns error message if invalid, null if valid
  static String? numeric(
    String? value, {
    String fieldName = 'Value',
    double? min,
    double? max,
    bool allowDecimal = true,
    String unit = '',
  }) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }

    final numValue = double.tryParse(value);
    if (numValue == null) {
      return 'Please enter a valid number';
    }

    if (!allowDecimal && numValue != numValue.toInt()) {
      return '$fieldName must be a whole number';
    }

    if (min != null && numValue < min) {
      final unitStr = unit.isNotEmpty ? ' $unit' : '';
      return 'Minimum $fieldName is $min$unitStr';
    }

    if (max != null && numValue > max) {
      final unitStr = unit.isNotEmpty ? ' $unit' : '';
      return 'Maximum $fieldName is $max$unitStr';
    }

    return null;
  }

  /// Validates weight with unit-specific ranges
  /// [value] - The weight value to validate
  /// [unit] - Unit ('kgs' or 'lbs')
  /// Returns error message if invalid, null if valid
  static String? weight(String? value, {String unit = 'kgs'}) {
    if (value == null || value.isEmpty) {
      return 'Please enter weight';
    }

    final weight = double.tryParse(value);
    final double minWeight;
    final double maxWeight;
    final String unitDisplay;

    if (unit == 'kgs') {
      minWeight = 0.1;
      maxWeight = 200.0;
      unitDisplay = 'kg';
    } else {
      minWeight = 0.2;
      maxWeight = 440.0;
      unitDisplay = 'lbs';
    }

    if (weight == null) {
      return 'Please enter Weight ($unit)';
    }

    if (weight < minWeight) {
      return 'Minimum weight is $minWeight $unitDisplay';
    }

    if (weight > maxWeight) {
      return 'Maximum weight is $maxWeight $unitDisplay';
    }

    return null;
  }

  /// Validates height with unit-specific ranges
  /// [value] - The height value to validate
  /// [unit] - Unit ('feet' or 'cms')
  /// Returns error message if invalid, null if valid
  static String? height(String? value, {String unit = 'feet'}) {
    if (value == null || value.isEmpty) {
      return null; // Height is optional
    }

    final height = double.tryParse(value);
    final double minHeight;
    final double maxHeight;
    final String unitDisplay;

    if (unit == 'feet') {
      minHeight = 0.15;
      maxHeight = 6.5;
      unitDisplay = 'ft';
    } else {
      minHeight = 5.0;
      maxHeight = 200.0;
      unitDisplay = 'cm';
    }

    if (height == null) {
      return 'Please enter Height ($unit)';
    }

    if (height < minHeight) {
      return 'Minimum height is $minHeight $unitDisplay';
    }

    if (height > maxHeight) {
      return 'Maximum height is $maxHeight $unitDisplay';
    }

    return null;
  }

  /// Validates text length constraints
  /// [value] - The text to validate
  /// [minLength] - Minimum length (optional)
  /// [maxLength] - Maximum length (optional)
  /// [fieldName] - The name of the field for error messages
  /// Returns error message if invalid, null if valid
  static String? textLength(
    String? value, {
    int? minLength,
    int? maxLength,
    String fieldName = 'Text',
  }) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }

    if (minLength != null && value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }

    if (maxLength != null && value.length > maxLength) {
      return '$fieldName must be at most $maxLength characters';
    }

    return null;
  }

  /// Validates URL format
  /// [value] - The URL to validate
  /// Returns error message if invalid, null if valid
  static String? url(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter URL';
    }

    try {
      Uri.parse(value);
      if (!value.startsWith('http://') && !value.startsWith('https://')) {
        return 'Please enter a valid URL (must start with http:// or https://)';
      }
      return null;
    } catch (e) {
      return 'Please enter a valid URL';
    }
  }

  /// Validates that at least one item is selected
  /// [value] - The selected value(s)
  /// [fieldName] - The name of the field for error messages
  /// Returns error message if invalid, null if valid
  static String? selected(dynamic value, {String fieldName = 'Selection'}) {
    if (value == null) {
      return 'Please select $fieldName';
    }

    if (value is String && value.isEmpty) {
      return 'Please select $fieldName';
    }

    if (value is List && value.isEmpty) {
      return 'Please select at least one $fieldName';
    }

    return null;
  }

  /// Validates date constraints
  /// [value] - The date string to validate (ISO 8601 format or custom format)
  /// [minDate] - Minimum allowed date (optional)
  /// [maxDate] - Maximum allowed date (optional)
  /// [fieldName] - The name of the field for error messages
  /// Returns error message if invalid, null if valid
  static String? dateRange(
    String? value, {
    DateTime? minDate,
    DateTime? maxDate,
    String fieldName = 'Date',
  }) {
    if (value == null || value.isEmpty) {
      return 'Please select $fieldName';
    }

    DateTime? parsedDate;
    try {
      parsedDate = DateTime.parse(value);
    } catch (e) {
      return 'Please enter a valid date';
    }

    if (minDate != null && parsedDate.isBefore(minDate)) {
      return '$fieldName cannot be before ${minDate.toString().split(' ')[0]}';
    }

    if (maxDate != null && parsedDate.isAfter(maxDate)) {
      return '$fieldName cannot be after ${maxDate.toString().split(' ')[0]}';
    }

    return null;
  }

  /// Validates age from a date of birth
  /// [dateOfBirth] - The date of birth
  /// [minAge] - Minimum age (optional)
  /// [maxAge] - Maximum age (optional)
  /// Returns error message if invalid, null if valid
  static String? age(DateTime? dateOfBirth, {int? minAge, int? maxAge}) {
    if (dateOfBirth == null) {
      return 'Please select date of birth';
    }

    final today = DateTime.now();
    int age = today.year - dateOfBirth.year;

    if (today.month < dateOfBirth.month ||
        (today.month == dateOfBirth.month && today.day < dateOfBirth.day)) {
      age--;
    }

    if (minAge != null && age < minAge) {
      return 'Must be at least $minAge years old';
    }

    if (maxAge != null && age > maxAge) {
      return 'Must be at most $maxAge years old';
    }

    return null;
  }

  /// Validates username format
  /// [value] - The username to validate
  /// [minLength] - Minimum length (default: 3)
  /// [maxLength] - Maximum length (default: 20)
  /// Returns error message if invalid, null if valid
  static String? username(
    String? value, {
    int minLength = 3,
    int maxLength = 20,
  }) {
    if (value == null || value.isEmpty) {
      return 'Please enter username';
    }

    if (value.length < minLength || value.length > maxLength) {
      return 'Username must be between $minLength and $maxLength characters';
    }

    // Allow alphanumeric, underscore, and hyphen
    if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, underscores, and hyphens';
    }

    return null;
  }

  /// Validates that file extension is allowed
  /// [fileName] - The file name to validate
  /// [allowedExtensions] - List of allowed extensions (e.g., ['jpg', 'png', 'pdf'])
  /// Returns error message if invalid, null if valid
  static String? fileExtension(
    String? fileName, {
    required List<String> allowedExtensions,
  }) {
    if (fileName == null || fileName.isEmpty) {
      return 'Please select a file';
    }

    final extension = fileName.split('.').last.toLowerCase();
    if (!allowedExtensions.contains(extension)) {
      return 'File type .$extension not allowed. Allowed types: ${allowedExtensions.join(', ')}';
    }

    return null;
  }

  /// Validates file size in bytes
  /// [fileSize] - The file size in bytes
  /// [maxSizeInMB] - Maximum allowed size in MB
  /// Returns error message if invalid, null if valid
  static String? fileSize(int? fileSize, {required double maxSizeInMB}) {
    if (fileSize == null) {
      return 'File size could not be determined';
    }

    final maxSizeInBytes = (maxSizeInMB * 1024 * 1024).toInt();
    if (fileSize > maxSizeInBytes) {
      return 'File size must not exceed ${maxSizeInMB.toStringAsFixed(2)} MB';
    }

    return null;
  }

  /// Validates credit card number using Luhn algorithm
  /// [value] - The credit card number to validate
  /// Returns error message if invalid, null if valid
  static String? creditCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter card number';
    }

    final cardNumber = value.replaceAll(RegExp(r'\s+'), '');

    if (!RegExp(r'^\d{13,19}$').hasMatch(cardNumber)) {
      return 'Please enter a valid card number';
    }

    if (!_luhnCheck(cardNumber)) {
      return 'Invalid card number';
    }

    return null;
  }

  /// Luhn algorithm for credit card validation
  static bool _luhnCheck(String cardNumber) {
    int sum = 0;
    bool isEven = false;

    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);

      if (isEven) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }

      sum += digit;
      isEven = !isEven;
    }

    return sum % 10 == 0;
  }

  /// Validates postal code format (supports multiple formats)
  /// [value] - The postal code to validate
  /// [country] - Country code for specific format validation ('US', 'CA', 'UK', etc.)
  /// Returns error message if invalid, null if valid
  static String? postalCode(String? value, {String country = 'US'}) {
    if (value == null || value.isEmpty) {
      return 'Please enter postal code';
    }

    String pattern;
    String formatExample;

    switch (country.toUpperCase()) {
      case 'US':
        pattern = r'^\d{5}(-\d{4})?$'; // 12345 or 12345-6789
        formatExample = '12345 or 12345-6789';
        break;
      case 'CA':
        pattern = r'^[A-Z]\d[A-Z]\s?\d[A-Z]\d$'; // A1A 1A1
        formatExample = 'A1A 1A1';
        break;
      case 'UK':
        pattern = r'^[A-Z]{1,2}\d{1,2}\s?\d[A-Z]{2}$'; // SW1A 1AA
        formatExample = 'SW1A 1AA';
        break;
      default:
        pattern = r'^[A-Z0-9]{3,10}$';
        formatExample = '3-10 alphanumeric characters';
    }

    if (!RegExp(pattern).hasMatch(value)) {
      return 'Please enter a valid postal code ($formatExample)';
    }

    return null;
  }

  /// Custom validation with a custom validator function
  /// [value] - The value to validate
  /// [validator] - Custom validation function that returns error message or null
  /// Returns error message from validator or null if valid
  static String? custom(dynamic value, String? Function(dynamic) validator) {
    return validator(value);
  }

  /// Composite validator that runs multiple validators
  /// [value] - The value to validate
  /// [validators] - List of validator functions to run
  /// Returns first error message encountered, or null if all pass
  static String? composite(
    dynamic value,
    List<String? Function(dynamic)> validators,
  ) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) {
        return error;
      }
    }
    return null;
  }

  /// Validates that value is not all whitespace
  /// [value] - The value to validate
  /// [fieldName] - The name of the field for error messages
  /// Returns error message if invalid, null if valid
  static String? notBlank(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName cannot be empty or whitespace';
    }
    return null;
  }

  /// Validates character constraints
  /// [value] - The text to validate
  /// [allowNumbers] - Allow numeric characters (default: true)
  /// [allowSpecial] - Allow special characters (default: false)
  /// [customPattern] - Custom regex pattern for validation (optional)
  /// [fieldName] - The name of the field for error messages
  /// Returns error message if invalid, null if valid
  static String? characterConstraints(
    String? value, {
    bool allowNumbers = true,
    bool allowSpecial = false,
    String? customPattern,
    String fieldName = 'Field',
  }) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }

    if (customPattern != null) {
      if (!RegExp(customPattern).hasMatch(value)) {
        return '$fieldName contains invalid characters';
      }
    } else {
      String pattern = r'^[a-zA-Z';
      if (allowNumbers) pattern += r'0-9';
      if (allowSpecial) pattern += r'!@#$%^&*(),.?":{}|<>\s';
      pattern += r']+$';

      if (!RegExp(pattern).hasMatch(value)) {
        return '$fieldName contains invalid characters';
      }
    }

    return null;
  }

  /// Validates that value matches a specific pattern
  /// [value] - The value to validate
  /// [pattern] - The regex pattern to match
  /// [errorMessage] - Custom error message
  /// Returns error message if invalid, null if valid
  static String? pattern(
    String? value, {
    required String pattern,
    String errorMessage = 'Invalid format',
  }) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }

    if (!RegExp(pattern).hasMatch(value)) {
      return errorMessage;
    }

    return null;
  }
}
