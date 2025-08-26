import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: const Text(
          'About Sustainable Living',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,  // Left align the AppBar title
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,  // Left align all text in column
            children: [
              // Big icon or logo for style
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.shade300.withOpacity(0.6),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: const Icon(
                    Icons.eco,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Text(
                'Welcome to Sustainable Living App',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 20),

              Text(
                'This app is designed to promote sustainable living through tools like carbon tracking, '
                'eco-product suggestions, and educational content. We aim to inspire users to adopt eco-friendly habits '
                'and contribute to a greener planet.',
                style: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                  color: Colors.green.shade800,
                ),
              ),
              const SizedBox(height: 25),

              Text(
                'Our Vision',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade900,
                ),
              ),
              const SizedBox(height: 10),

              Text(
                'To create a sustainable future where everyone is conscious of their environmental impact and actively contributes to preserving nature.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.green.shade700,
                ),
              ),
              const SizedBox(height: 25),

              Text(
                'Features',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade900,
                ),
              ),
              const SizedBox(height: 10),

              _featureRow(Icons.track_changes, 'Carbon Footprint Tracker'),
              const SizedBox(height: 8),
              _featureRow(Icons.eco, 'Eco-friendly Product Suggestions'),
              const SizedBox(height: 8),
              _featureRow(Icons.school, 'Educational Content and Tips'),
              const SizedBox(height: 8),
              _featureRow(Icons.group, 'Community Forums and Challenges'),

              const SizedBox(height: 40),

              Center(
                child: Text(
                  'Together, let’s make the world greener 🌍',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade700,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.green.shade700, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 17,
              color: Colors.green.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
