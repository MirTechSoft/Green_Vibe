import 'package:flutter/material.dart';

class QuickTipsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> tips = [
    {
      'text': 'Turn off lights when not in use.',
      'icon': Icons.lightbulb_outline,
    },
    {
      'text': 'Use reusable shopping bags.',
      'icon': Icons.shopping_bag_outlined,
    },
    {
      'text': 'Take shorter showers.',
      'icon': Icons.water_drop_outlined,
    },
    {
      'text': 'Plant a tree in your community.',
      'icon': Icons.park_outlined,
    },
    {
      'text': 'Recycle properly to reduce landfill waste.',
      'icon': Icons.recycling_outlined,
    },
  ];

  QuickTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade700, Colors.green.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Quick Tips',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: tips.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 3,
            shadowColor: Colors.green.shade200,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade100,
                child: Icon(
                  tips[index]['icon'],
                  color: Colors.green.shade700,
                ),
              ),
              title: Text(
                tips[index]['text'],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(
                Icons.check_circle_outline,
                color: Colors.green.shade700,
              ),
            ),
          );
        },
      ),
    );
  }
}
