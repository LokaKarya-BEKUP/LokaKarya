import 'package:flutter/material.dart';
import 'package:lokakarya/style/colors/app_colors.dart';

enum SnackBarType { info, success, warning, error }

void showAppSnackBar({
  required BuildContext context,
  required String message,
  SnackBarType type = SnackBarType.info,
  int durationSeconds = 3,
}) {
  late Color borderColor;
  late Color backgroundColor;
  late Color iconColor;
  late IconData icon;

  switch (type) {
    /// SnackBar Success
    case SnackBarType.success:
      borderColor = Colors.teal;
      backgroundColor = Colors.teal.shade50;
      iconColor = Colors.teal;
      icon = Icons.check_circle;
      break;

    /// SnackBar Warning
    case SnackBarType.warning:
      borderColor = Colors.orange;
      backgroundColor = Colors.orange.shade50;
      iconColor = Colors.orange;
      icon = Icons.warning_rounded;
      break;

    /// SnackBar Error
    case SnackBarType.error:
      borderColor = Colors.red;
      backgroundColor = Colors.red.shade50;
      iconColor = Colors.red;
      icon = Icons.cancel_rounded;
      break;

    /// Default SnackBar
    default:
      borderColor = Colors.blue;
      backgroundColor = Colors.blue.shade50;
      iconColor = Colors.blue;
      icon = Icons.info;
      break;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1.8),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: borderColor.withAlpha(30),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: iconColor),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              child: Icon(Icons.close, color: AppColors.neutral90, size: 20),
            ),
          ],
        ),
      ),
      duration: Duration(seconds: durationSeconds),
    ),
  );
}

/// Snackbar for Coming Soon Feature
void showComingSoonSnackBar(BuildContext context, {String? featureName}) {
  showAppSnackBar(
    context: context,
    message: featureName != null
      ? "Fitur $featureName akan segera hadir di pembaruan berikutnya!"
      : "Fitur ini akan segera hadir di pembaruan berikutnya!",
    type: SnackBarType.info,
  );
}