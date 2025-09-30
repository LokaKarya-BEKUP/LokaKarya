import 'package:flutter/material.dart';
import 'package:lokakarya/provider/auth/signin/signin_provider.dart';
import 'package:lokakarya/static/navigation_route.dart';
import 'package:lokakarya/widgets/auth_header.dart';
import 'package:lokakarya/widgets/auth_text_field.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: Column(
        children: [
          /// Header (Logo & App Name)
          AuthHeader(),

          /// Body Content (Form & Button)
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                        Text("Selamat Datang", style: textTheme.headlineMedium),
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
                        return Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              /// Email
                              AuthTextField(
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
                                label: "Password",
                                icon: Icons.lock_outline,
                                obscureText: provider.isPasswordHidden,
                                suffixIcon: Icon(
                                  provider.isPasswordHidden
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: colorScheme.outline,
                                ),
                                onSuffixTap: provider.togglePasswordVisibility,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                    ? "Password tidak boleh kosong"
                                    : null,
                              ),
                              const SizedBox(height: 32),

                              /// Sign in Button
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text("Masuk"),
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
    );
  }
}
