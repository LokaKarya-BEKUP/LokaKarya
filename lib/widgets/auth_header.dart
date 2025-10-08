import 'package:flutter/material.dart';

import '../style/typography/app_text_styles.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 32, top: 16),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// App Name
          Text(
            "LokaKarya",
            style: AppTextStyles.logoTitle.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 16),

          /// App Logo
          Image.asset(
            "assets/images/app_logo.png",
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
