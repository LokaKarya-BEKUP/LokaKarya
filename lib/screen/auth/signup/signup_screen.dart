import 'package:flutter/material.dart';
import 'package:lokakarya/provider/auth/signup/signup_provider.dart';
import 'package:lokakarya/static/firebase_auth_status.dart';
import 'package:lokakarya/utils/app_snackbar.dart';
import 'package:lokakarya/widgets/auth_header.dart';
import 'package:lokakarya/widgets/auth_text_field.dart';
import 'package:provider/provider.dart';

import '../../../static/navigation_route.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  /// Controller input
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Fungsi tap Register
  Future<void> _tapToRegister(BuildContext context) async {
    final provider = context.read<SignUpProvider>();

    /// Validasi Form Key
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Validasi password & konfirmasi password
    if (password != confirmPassword) {
      showAppSnackBar(
        context: context,
        message: "Konfirmasi password tidak sesuai",
        type: SnackBarType.error,
      );
      return;
    }

    // Proses register
    await provider.createAccount(name, email, password);

    // Cek hasil registrasi
    if (provider.authStatus == FirebaseAuthStatus.accountCreated) {
      if (!context.mounted) return;

      // Tampilkan snackbar success
      showAppSnackBar(
        context: context,
        message: "Berhasil mendaftarkan akun.",
        type: SnackBarType.success,
      );

      // Navigasi kembali ke halaman Sign In
      Navigator.pushReplacementNamed(context, NavigationRoute.signInRoute.name);
    } else {
      if (!context.mounted) return;

      showAppSnackBar(
        context: context,
        message: provider.message ?? "",
        type: SnackBarType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            /// Header (Logo & App Name)
            AuthHeader(),

            /// Body Content (Form & Button)
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  color: colorScheme.surface,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      /// Title & Subtitle
                      Column(
                        children: [
                          Text("Daftar", style: textTheme.headlineMedium),
                          const SizedBox(height: 8),
                          Text(
                            "Buat akun untuk mulai jelajahi produk lokal",
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      /// Form
                      Consumer<SignUpProvider>(
                        builder: (context, provider, child) {
                          return Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                /// Name
                                AuthTextField(
                                  controller: _nameController,
                                  label: "Nama",
                                  icon: Icons.person_outline,
                                  keyboardType: TextInputType.name,
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? "Nama tidak boleh kosong"
                                      : null,
                                ),
                                const SizedBox(height: 16),

                                /// Email
                                AuthTextField(
                                  controller: _emailController,
                                  label: "Email",
                                  icon: Icons.email_outlined,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? "Email tidak boleh kosong"
                                      : null,
                                ),
                                const SizedBox(height: 16),

                                /// Password
                                AuthTextField(
                                  controller: _passwordController,
                                  label: "Password",
                                  icon: Icons.lock_outline,
                                  obscureText: provider.isPasswordHidden,
                                  suffixIcon: Icon(
                                    provider.isPasswordHidden
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: colorScheme.outline,
                                  ),
                                  onSuffixTap:
                                      provider.togglePasswordVisibility,
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? "Password tidak boleh kosong"
                                      : null,
                                ),
                                const SizedBox(height: 16),

                                /// Confirm Password
                                AuthTextField(
                                  controller: _confirmPasswordController,
                                  label: "Konfirmasi Password",
                                  icon: Icons.lock_outline,
                                  obscureText: provider.isPasswordHidden,
                                  suffixIcon: Icon(
                                    provider.isPasswordHidden
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: colorScheme.outline,
                                  ),
                                  onSuffixTap:
                                      provider.togglePasswordVisibility,
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? "Konfirmasi Password tidak boleh kosong"
                                      : null,
                                ),
                                const SizedBox(height: 32),

                                // Sign up Button
                                ElevatedButton(
                                  onPressed:
                                      provider.authStatus ==
                                          FirebaseAuthStatus.creatingAccount
                                      ? null
                                      : () => _tapToRegister(context),
                                  child:
                                      provider.authStatus ==
                                          FirebaseAuthStatus.creatingAccount
                                      ? const CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        )
                                      : const Text("Daftar"),
                                ),
                                const SizedBox(height: 16),

                                /// Navigate to Sign in
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sudah memiliki akun?",
                                      style: textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          NavigationRoute.signInRoute.name,
                                        );
                                      },
                                      child: Text(
                                        "Masuk",
                                        style: textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
