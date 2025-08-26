import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sustainable_living_app/data/db_helper.dart';
import 'package:sustainable_living_app/screens/ProfileViewScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';
  String userEmail = '';

  late TextEditingController _nameController;
  late TextEditingController _emailController;

  ImageProvider? _profileImage;

  final String keyUserName = 'user_name';
  final String keyUserEmail = 'user_email';
  final String keyUserImage = 'user_image';

  final List<String> sampleImages = [
    'assets/images/avatar1.jpg',
    'assets/images/avatar2.jpg',
    'assets/images/avatar3.jpg',
    'assets/images/avatar4.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString(keyUserName) ?? '';
      userEmail = prefs.getString(keyUserEmail) ?? '';

      String? imgPath = prefs.getString(keyUserImage);
      if (imgPath != null && sampleImages.contains(imgPath)) {
        _profileImage = AssetImage(imgPath);
      } else {
        _profileImage = const AssetImage('assets/images/avatar.png');
      }

      _nameController.text = userName;
      _emailController.text = userEmail;
    });
  }

  Future<void> _saveProfile() async {
    String newName = _nameController.text.trim();
    await DBHelper.instance.updateUser(userEmail, newName, userEmail);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyUserName, newName);

    String? imgPath;
    for (var path in sampleImages) {
      if (_profileImage is AssetImage &&
          (_profileImage as AssetImage).assetName == path) {
        imgPath = path;
        break;
      }
    }
    if (imgPath != null) {
      await prefs.setString(keyUserImage, imgPath);
    }

    setState(() {
      userName = newName;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ProfileViewScreen()),
    );
  }

  void _cancelEdit() {
    Navigator.pop(context);
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(12),
        height: 180,
        child: GridView.builder(
          itemCount: sampleImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final imgPath = sampleImages[index];
            return GestureDetector(
              onTap: () async {
                setState(() {
                  _profileImage = AssetImage(imgPath);
                });
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString(keyUserImage, imgPath);
                Navigator.pop(context);
              },
              child: ClipOval(
                child: Image.asset(
                  imgPath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.person, size: 40, color: Colors.grey),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // ✅ Custom Input Decoration with black focused border
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black, width: 2),
      ),
      filled: true,
      fillColor: Colors.grey.shade100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  _profileImage != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.green[200],
                          backgroundImage: _profileImage,
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.green[200],
                          child: const Icon(Icons.person, size: 50, color: Colors.white),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: GestureDetector(
                      onTap: _showImagePicker,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green.shade700,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Name Field
            TextFormField(
              controller: _nameController,
              decoration: _inputDecoration('Name'),
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),

            // Email Field (Read Only)
            TextFormField(
              controller: _emailController,
              decoration: _inputDecoration('Email (cannot change)'),
              readOnly: true,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: _cancelEdit,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
