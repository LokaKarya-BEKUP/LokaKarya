import 'package:flutter/material.dart';
import 'package:lokakarya/services/url_launcher_service.dart';
import 'package:lokakarya/utils/app_snackbar.dart';

import '../../../data/model/store.dart';
import '../../../style/colors/app_colors.dart';

class ContactSellerSection extends StatelessWidget {
  final Store? store;
  final String? productName;

  const ContactSellerSection({super.key, this.store, this.productName});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hubungi Penjual",
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),

          /// Button Whatsapp
          ElevatedButton.icon(
            onPressed: () async {
              final message = "Halo ${store!.name},\n"
                  "saya tertarik dengan produk *${productName ?? 'Anda'}*.\n"
                  "Apakah masih tersedia?";

              final success = await UrlLauncerService.openWhatsApp(
                phone: store!.phone,
                message: message,
              );

              /// Tampilkan snackbar ketika gagal
              if (!success && context.mounted) {
                showAppSnackBar(
                  context: context,
                  message: "Tidak dapat membuka WhatsApp di perangkat ini.",
                  type: SnackBarType.error,
                );
              }
            },
            icon: Image.asset(
              "assets/icons/whatsapp.png",
              width: 28,
              height: 28,
            ),
            label: const Text("Hubungi via Whatsapp"),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success50,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
