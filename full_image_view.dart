import 'package:flutter/material.dart';

class FullImageView extends StatelessWidget {
  final String imagePath;

  const FullImageView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.asset(
            imagePath,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.broken_image, color: Colors.white, size: 80);
            },
          ),
        ),
      ),
    );
  }
}
