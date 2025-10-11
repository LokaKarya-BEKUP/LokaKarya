import 'package:flutter/material.dart';
import 'package:lokakarya/provider/main/profile_provider.dart';
import 'package:lokakarya/style/colors/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:lokakarya/static/navigation_route.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showEditNameDialog(BuildContext context, ProfileProvider provider) {
    final TextEditingController nameController = TextEditingController(
      text: provider.name,
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Nama"),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Nama Baru"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                provider.updateName(nameController.text);
                Navigator.of(context).pop();
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final profileProvider = context.watch<ProfileProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Profil Saya"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // TODO: Tambahkan fungsionalitas untuk memilih foto dari galeri
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Fitur edit foto akan ditambahkan nanti!",
                        ),
                      ),
                    );
                  },
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
                    Text(profileProvider.name, style: textTheme.headlineMedium),
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
                  "johndoe@email.com", // TODO: Ganti dengan data email sesungguhnya
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 32),

                ListTile(
                  leading: Icon(Icons.logout, color: colorScheme.error),
                  title: Text("Keluar", style: textTheme.titleMedium),
                  onTap: () {
                    // Logika logout
                    // Kita akan kembali ke halaman splash atau login
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      NavigationRoute.signInRoute.name,
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
