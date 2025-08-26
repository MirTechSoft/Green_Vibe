import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sustainable_living_app/data/db_helper.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String? email; // Logged-in user email
  const ChangePasswordScreen({super.key, this.email});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? _userEmail;

  // Eye toggle
  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    if (widget.email != null && widget.email!.isNotEmpty) {
      setState(() => _userEmail = widget.email);
    } else {
      final prefs = await SharedPreferences.getInstance();
      setState(() => _userEmail = prefs.getString('user_email')); // consistent key
    }
  }

  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    if (_userEmail == null || _userEmail!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("No logged-in user found"),
          backgroundColor: Colors.green.shade700,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final oldPass = _oldPassController.text.trim();
    final newPass = _newPassController.text.trim();

    final result = await DBHelper.instance.updatePassword(_userEmail!, oldPass, newPass);

    setState(() => _isLoading = false);

    if (result > 0) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_password', newPass);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Password updated successfully"),
          backgroundColor: Colors.green.shade700,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Old password is incorrect"),
          backgroundColor: Colors.green.shade700,
        ),
      );
    }
  }

  @override
  void dispose() {
    _oldPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback toggleVisibility,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey.shade600,
          ),
          onPressed: toggleVisibility,
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change Password",
          style: TextStyle(color: Colors.white), // Title color white
        ),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.black, // Arrow/back icon color black
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildPasswordField(
                controller: _oldPassController,
                label: "Old Password",
                obscureText: _obscureOld,
                toggleVisibility: () => setState(() => _obscureOld = !_obscureOld),
                validator: (val) => (val == null || val.isEmpty) ? "Enter old password" : null,
              ),
              const SizedBox(height: 16),
              _buildPasswordField(
                controller: _newPassController,
                label: "New Password",
                obscureText: _obscureNew,
                toggleVisibility: () => setState(() => _obscureNew = !_obscureNew),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Enter new password";
                  if (val.length < 6) return "Password must be at least 6 characters";
                  if (val == _oldPassController.text) return "New password must be different";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildPasswordField(
                controller: _confirmPassController,
                label: "Confirm New Password",
                obscureText: _obscureConfirm,
                toggleVisibility: () => setState(() => _obscureConfirm = !_obscureConfirm),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Confirm your password";
                  if (val != _newPassController.text) return "Passwords do not match";
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Update Password",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
