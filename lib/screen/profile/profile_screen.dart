import 'package:flutter/material.dart';
import 'package:lokakarya/provider/main/profile_provider.dart';
import 'package:lokakarya/provider/main/theme_provider.dart';
import 'package:lokakarya/style/colors/app_colors.dart';
import 'package:lokakarya/utils/app_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:lokakarya/static/navigation_route.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  /// Fungsi Update Nama
  void _showEditNameDialog(BuildContext context, ProfileProvider provider) {
    final TextEditingController nameController = TextEditingController(
      text: provider.user?.name ?? "",
    );

    // Simpan context utama
    final parentContext = context;

    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Edit Nama"),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Nama Baru"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () async {
                final newName = nameController.text.trim();
                if (newName.isEmpty) {
                  showAppSnackBar(
                    context: parentContext,
                    message: "Nama tidak boleh kosong.",
                    type: SnackBarType.error,
                  );
                  return;
                }

                await provider.updateUserName(newName);

                if (!parentContext.mounted) return;

                if (provider.errorMessage == null) {
                  showAppSnackBar(
                    context: parentContext,
                    message: "Nama berhasil diperbarui!",
                    type: SnackBarType.success,
                  );
                } else {
                  showAppSnackBar(
                    context: parentContext,
                    message: provider.errorMessage!,
                    type: SnackBarType.error,
                  );
                }

                Navigator.of(dialogContext).pop();
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  /// Fungsi Logout
  Future<void> _onTapLogout(BuildContext context) async {
    final profileProvider = context.read<ProfileProvider>();

    await profileProvider.signOut(context);

    if (context.mounted) {
      showAppSnackBar(
        context: context,
        message: "Logout berhasil.",
        type: SnackBarType.success,
      );

      Navigator.of(context).pushNamedAndRemoveUntil(
        NavigationRoute.signInRoute.name,
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final profileProvider = context.watch<ProfileProvider>();
    final themeProvider = Provider.of<ThemeProvider>(context);

    final user = profileProvider.user;
    final isLoading = profileProvider.isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text("Profil Saya"), centerTitle: true),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => showComingSoonSnackBar(
                          context,
                          featureName: "Edit Foto",
                        ),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: colorScheme.primary,
                              backgroundImage: const AssetImage(
                                "assets/images/profile_default.png",
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.neutral70,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isLoading)
                            const CircularProgressIndicator()
                          else
                            Text(
                              isLoading
                                  ? "Memuat..."
                                  : (user?.name ?? "Nama Pengguna"),
                              style: textTheme.headlineMedium,
                            ),

                          if (!isLoading)
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                size: 20,
                                color: colorScheme.onSurface,
                              ),
                              onPressed: () =>
                                  _showEditNameDialog(context, profileProvider),
                            ),
                        ],
                      ),
                      Text(
                        isLoading
                            ? "-"
                            : user?.email ??
                                  "-", // TODO: Ganti dengan data email sesungguhnya
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: colorScheme.onSurface.withAlpha(80),
                        ),
                      ),
                      const SizedBox(height: 32),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// Dark Mode toggle
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: colorScheme.outline,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// Icon & title
                                Row(
                                  children: [
                                    Icon(
                                      Icons.dark_mode_outlined,
                                      color: colorScheme.outline,
                                      size: 32,
                                    ),
                                    const SizedBox(width: 12),

                                    Text(
                                      "Mode Gelap",
                                      style: textTheme.bodyLarge,
                                    ),
                                  ],
                                ),

                                /// Toggle
                                Switch.adaptive(
                                  value: themeProvider.isDarkMode,
                                  onChanged: (value) {
                                    themeProvider.toggleTheme(value);
                                  },
                                  activeThumbColor: colorScheme.primary,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      /// Logout button
                      OutlinedButton(
                        onPressed: () => _onTapLogout(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: colorScheme.outline,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Icon Logout & Title
                            Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: colorScheme.outline,
                                  size: 32,
                                ),
                                const SizedBox(width: 12),
                                Text("Keluar", style: textTheme.bodyLarge),
                              ],
                            ),

                            /// Icon arrow right
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: colorScheme.outline,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
