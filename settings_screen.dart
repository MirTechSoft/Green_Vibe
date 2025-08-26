import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../FontSizeProvider.dart';
import 'privacy_policy_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart';
import 'change_password_screen.dart'; // ✅ Fixed import

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showFontSizeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Font Size"),
          content: Consumer<FontSizeProvider>(
            builder: (context, provider, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: const Text("Small"),
                    value: "Small",
                    groupValue: provider.fontSize,
                    onChanged: (val) {
                      if (val != null) {
                        provider.setFontSize(val);
                        Navigator.pop(context);
                      }
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text("Medium"),
                    value: "Medium",
                    groupValue: provider.fontSize,
                    onChanged: (val) {
                      if (val != null) {
                        provider.setFontSize(val);
                        Navigator.pop(context);
                      }
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text("Large"),
                    value: "Large",
                    groupValue: provider.fontSize,
                    onChanged: (val) {
                      if (val != null) {
                        provider.setFontSize(val);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FontSizeProvider>(
      builder: (context, fontSizeProvider, child) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.green.shade700,
            title: Text(
              'Settings',
              style: TextStyle(color: Colors.white, fontSize: fontSizeProvider.fontSizeValue),
            ),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSectionTitle("Account", fontSizeProvider.fontSizeValue),
              _buildListTile(
                icon: Icons.person_outline,
                title: "Edit Profile",
                fontSize: fontSizeProvider.fontSizeValue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                  );
                },
              ),
              _buildListTile(
                icon: Icons.lock_outline,
                title: "Change Password",
                fontSize: fontSizeProvider.fontSizeValue,
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  final email = prefs.getString('user_email'); // ✅ Fixed key

                  if (email != null && email.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ChangePasswordScreen(email: email)),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("No logged-in user found")),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              _buildSectionTitle("App Settings", fontSizeProvider.fontSizeValue),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: Icon(Icons.format_size, color: Colors.green.shade700),
                  title: Text(
                    "App Font Size (${fontSizeProvider.fontSize})",
                    style: TextStyle(fontSize: fontSizeProvider.fontSizeValue),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _showFontSizeDialog(context),
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle("Other", fontSizeProvider.fontSizeValue),
              _buildListTile(
                icon: Icons.privacy_tip_outlined,
                title: "Privacy Policy",
                fontSize: fontSizeProvider.fontSizeValue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
                  );
                },
              ),
              _buildListTile(
                icon: Icons.logout,
                title: "Logout",
                fontSize: fontSizeProvider.fontSizeValue,
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.green.shade800,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required double fontSize,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: Colors.green.shade700),
        title: Text(title, style: TextStyle(fontSize: fontSize)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
