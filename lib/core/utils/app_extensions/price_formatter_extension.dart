extension DoubleFormatter on double {
  String formatPrice() {
    // 'this' refers to the double value itself
    if (this % 1 == 0) {
      return toInt().toString();
    } else {
      return toStringAsFixed(2);
    }
  }
}
