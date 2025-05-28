import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;

    // Hilangkan semua karakter selain angka
    String numericString = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Parse angka
    final number = int.tryParse(numericString) ?? 0;

    // Format ulang
    final newText = formatter.format(number);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

formatRupiah(int amount) {
  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);
  return formatter.format(amount);
}
