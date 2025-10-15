import 'package:flutter/material.dart';
import 'package:lokakarya/provider/auth/signin/signin_provider.dart';
import 'package:lokakarya/static/firebase_auth_status.dart';
import 'package:lokakarya/static/navigation_route.dart';
import 'package:lokakarya/utils/app_snackbar.dart';
import 'package:lokakarya/widgets/auth_header.dart';
import 'package:lokakarya/widgets/auth_text_field.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  /// Controller input
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _tapToSignIn() async {
    final provider = context.read<SignInProvider>();

    /// Validasi form
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    /// Proses Sign in
    await provider.signInUser(email, password);

    if (!mounted) return;

    switch (provider.authStatus) {
      case FirebaseAuthStatus.authenticated:
        showAppSnackBar(
          context: context,
          message: provider.message ?? "Login berhasil.",
          type: SnackBarType.success,
        );

        // Navigasi ke halaman beranda
        Future.delayed(const Duration(milliseconds: 800), () {
          if (!mounted) return;
          Navigator.pushNamedAndRemoveUntil(
            context,
            NavigationRoute.mainRoute.name,
            (route) => false,
          );
        });
        break;

      case FirebaseAuthStatus.error:
        showAppSnackBar(
          context: context,
          message: provider.message ?? "Login gagal.",
          type: SnackBarType.error,
        );
        break;

      default:
        break;
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
                      // Title & Subtitle
                      Column(
                        children: [
                          Text(
                            "Selamat Datang",
                            style: textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Masuk dan temukan produk lokal di sekitarmu",
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      /// Form
                      Consumer<SignInProvider>(
                        builder: (context, provider, child) {
                          final isLoading =
                              provider.authStatus ==
                              FirebaseAuthStatus.authenticating;

                          return Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
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
                                const SizedBox(height: 32),

                                /// Sign in Button
                                ElevatedButton(
                                  onPressed: isLoading ? null : _tapToSignIn,
                                  child: isLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text("Masuk"),
                                ),
                                const SizedBox(height: 16),

                                /// Create Account Button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Belum memiliki akun?",
                                      style: textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          NavigationRoute.signUpRoute.name,
                                        );
                                      },
                                      child: Text(
                                        "Daftar",
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
