import 'package:flutter/material.dart';

class CertificationsScreen extends StatefulWidget {
  const CertificationsScreen({super.key});

  @override
  State<CertificationsScreen> createState() => _CertificationsScreenState();
}

class _CertificationsScreenState extends State<CertificationsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;

  final List<Map<String, String>> certifications = [
    {
      'title': 'Fair Trade',
      'desc': 'Supports better trading conditions and sustainable farming.',
      'icon': '🌍'
    },
    {
      'title': 'Energy Star',
      'desc': 'Recognized for energy efficiency in appliances and buildings.',
      'icon': '⚡'
    },
    {
      'title': 'USDA Organic',
      'desc': 'Certified organic food and agricultural products.',
      'icon': '🌱'
    },
    {
      'title': 'LEED',
      'desc': 'Leadership in Energy and Environmental Design for buildings.',
      'icon': '🏢'
    },
    {
      'title': 'Rainforest Alliance',
      'desc': 'Supports biodiversity and sustainable livelihoods.',
      'icon': '🌳'
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimations = certifications.asMap().entries.map((entry) {
      int index = entry.key;
      return Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(index * 0.15, 1.0, curve: Curves.easeOut),
      ));
    }).toList();

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Eco Certifications",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // Green vertical line for timeline
            Positioned(
              left: 28,
              top: 0,
              bottom: 0,
              child: Container(
                width: 4,
                color: Colors.green.shade300,
              ),
            ),
            ListView.builder(
              itemCount: certifications.length,
              itemBuilder: (context, index) {
                return SlideTransition(
                  position: _slideAnimations[index],
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon Circle
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.green.shade100,
                          child: Text(
                            certifications[index]['icon']!,
                            style: const TextStyle(fontSize: 28),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Text content
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  certifications[index]['title']!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  certifications[index]['desc']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
