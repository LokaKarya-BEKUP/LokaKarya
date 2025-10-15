import 'dart:io';

String getErrorMessage(Exception e) {
  if (e is SocketException) {
    return "Tidak ada koneksi internet. Periksa jaringan Anda.";
  } else if (e is HttpException) {
    return "Terjadi kesalahan pada server. Silakan coba lagi nanti.";
  } else if (e is FormatException) {
    return "Data yang diterima tidak valid.";
  } else {
    return 'Terjadi kesalahan yang tidak terduga. Silakan coba lagi.';
  }
}