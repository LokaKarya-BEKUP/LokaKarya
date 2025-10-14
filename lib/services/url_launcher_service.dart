import 'package:url_launcher/url_launcher.dart';

class UrlLauncerService {
  /// Membuka link WhatsApp berdasarkan nomor telepon
  static Future<bool> openWhatsApp({
    required String phone,
    String? message,
  }) async {
    final Uri whatsappUrl = Uri.parse(
      "https://wa.me/$phone?text=${Uri.encodeComponent(message ?? '')}",
    );

    final canLaunch = await canLaunchUrl(whatsappUrl);

    if (canLaunch) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      return true;
    } else {
      return false;
    }
  }
}
