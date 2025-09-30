import 'package:flutter/material.dart';
import 'package:lokakarya/provider/auth/signup/signup_provider.dart';
import 'package:lokakarya/widgets/auth_header.dart';
import 'package:lokakarya/widgets/auth_text_field.dart';
import 'package:provider/provider.dart';

import '../../../static/navigation_route.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
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
                              const SizedBox(height: 16),

                              /// Confirm Password
                              AuthTextField(
                                label: "Konfirmasi Password",
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
                                    ? "Konfirmasi Password tidak boleh kosong"
                                    : null,
                              ),
                              const SizedBox(height: 32),

                              // Sign up Button
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text("Daftar"),
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
    );
  }
}
