import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool autofocus;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;

  const AuthTextField({
    super.key,
    required this.label,
    this.icon,
    this.controller,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.autofocus = false,
    this.suffixIcon,
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,

        /// Input Icon
        prefixIcon: icon != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: colorScheme.outline)),
                ),
                child: Icon(icon, color: colorScheme.outline),
              )
            : null,
        prefixIconConstraints: const BoxConstraints(minWidth: 50),

        /// Suffix Icon (Optional)
        suffixIcon: suffixIcon != null
            ? GestureDetector(onTap: onSuffixTap, child: suffixIcon)
            : null,
      ),
    );
  }
}
