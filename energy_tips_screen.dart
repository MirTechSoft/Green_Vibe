import 'package:flutter/material.dart';

class EnergyTipsScreen extends StatelessWidget {
  final List<Map<String, String>> tips = [
    {
      'title': 'Unplug Devices',
      'description': 'Unplug chargers and devices when not in use to save energy.',
    },
    {
      'title': 'Use LED Bulbs',
      'description': 'Switch to LED lights — they use up to 90% less energy.',
    },
    {
      'title': 'Wash with Cold Water',
      'description': 'Washing clothes in cold water saves both energy and money.',
    },
    {
      'title': 'Smart Thermostat',
      'description': 'Use smart thermostats to regulate temperature efficiently.',
    },
  ];

  EnergyTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text(
          'Energy Conservation Tips',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false, // <-- Heading left aligned yahan se
        elevation: 4,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            // Banner with asset image + error handler
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade200.withOpacity(0.6),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  'assets/images/energy_tips_banner.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(Icons.broken_image, size: 60, color: Colors.grey[600]),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Section Title with underline
            Text(
              'Top Tips to Save Energy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              height: 4,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 16),

            ...tips.asMap().entries.map((entry) {
              final index = entry.key;
              final tip = entry.value;
              return _energyTipCard(tip, index);
            }),

            const SizedBox(height: 30),

            // Motivational Quote Box
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade300.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.eco, size: 40, color: Colors.green.shade700),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      '“Saving energy today secures a better tomorrow.”',
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.green.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _energyTipCard(Map<String, String> tip, int index) {
    final bgColors = [
      Colors.white,
      Colors.green.shade50,
      Colors.white,
      Colors.green.shade50,
    ];
    final iconColors = [
      Colors.orange.shade700,
      Colors.blue.shade700,
      Colors.purple.shade700,
      Colors.teal.shade700,
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: bgColors[index % bgColors.length],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
        border: Border.all(color: Colors.green.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        leading: CircleAvatar(
          backgroundColor: iconColors[index % iconColors.length],
          radius: 28,
          child: const Icon(
            Icons.flash_on,
            color: Colors.white,
            size: 28,
          ),
        ),
        title: Text(
          tip['title'] ?? '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.green.shade900,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            tip['description'] ?? '',
            style: TextStyle(
              fontSize: 14,
              color: Colors.green.shade800,
            ),
          ),
        ),
      ),
    );
  }
}
