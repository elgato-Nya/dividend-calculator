// Validates the invested fund input. Returns error message if invalid.
String? validateFund(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter invested fund';
  }
  final v = double.tryParse(value);
  if (v == null || v <= 0) {
    return 'Enter a positive number';
  }
  return null;
}

// Validates the dividend rate input. Returns error message if invalid.
String? validateRate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter dividend rate';
  }
  final v = double.tryParse(value);
  if (v == null || v <= 0) {
    return 'Enter a positive rate';
  }
  return null;
}

// Validates the months invested input. Must be between 1 and 12.
String? validateMonths(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter months invested';
  }
  final v = int.tryParse(value);
  if (v == null || v < 1 || v > 12) {
    return 'Enter months between 1 and 12';
  }
  return null;
}
