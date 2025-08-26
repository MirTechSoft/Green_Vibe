import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  final Map<String, String> _sections = const {
    'Privacy Policy': '',
    'Effective date': 'August 2025',
    '1. Information We Collect': '- Personal data you provide such as name, email, etc.\n- Usage data like app interactions and preferences.',
    '2. How We Use Information': '- To improve app functionality and personalize your experience.\n- To communicate important updates and promotions.',
    '3. Data Security': 'We implement industry-standard measures to safeguard your data.',
    '4. Sharing Information': 'We do not sell your personal data to third parties.',
    '5. Your Rights': 'You can request to access, update, or delete your personal information.',
    '6. Contact Us': 'If you have questions about this Privacy Policy, contact us at support@sustainableapp.com.',
    'Thank You': 'Thank you for trusting us with your information!',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        // Arrow color black
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 2,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            color: Colors.white,  // Title text white
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Scrollbar(
        thumbVisibility: true,
        thickness: 6,
        radius: const Radius.circular(10),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _sections.entries.map((entry) {
              final heading = entry.key;
              final content = entry.value;

              if (heading == 'Privacy Policy' || heading == 'Thank You') {
                // Big centered titles with green for Thank You, white for Privacy Policy handled above in AppBar
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Center(
                    child: Text(
                      heading,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: heading == 'Privacy Policy' ? Colors.green.shade900 : Colors.green.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }

              if (heading == 'Effective date') {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    '$heading: $content',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                );
              }

              // Normal section with heading + content
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      heading,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      content,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
