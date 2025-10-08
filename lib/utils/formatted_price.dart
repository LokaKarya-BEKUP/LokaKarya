import 'package:intl/intl.dart';

/// Contoh: 25000 -> Rp 25.000
String formatRupiah(int price) {
  return NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  ).format(price);
}
