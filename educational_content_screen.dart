import 'package:flutter/material.dart';

import 'articles_screen.dart';
import 'videos_screen.dart';
import 'quick_tips_screen.dart';

class EducationalContentScreen extends StatelessWidget {
  final List<Map<String, String>> popularTopics = [
    {
      'title': 'Why Sustainability Matters',
      'desc': 'Learn why eco-conscious living is critical for our planet.',
    },
    {
      'title': 'How Carbon Footprint Works',
      'desc': 'Understand what it is and how to reduce yours.',
    },
    {
      'title': 'Benefits of Eco-Friendly Habits',
      'desc': 'Explore how small changes lead to a better world.',
    },
    {
      'title': 'Basics of Renewable Energy',
      'desc': 'Introduction to solar, wind, and other clean sources.',
    },
  ];

  EducationalContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Educational Content',
          style: TextStyle(color: Colors.white),  // White color for heading
        ),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Article Banner
            Container(
              margin: const EdgeInsets.all(16),
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/education_banner.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black.withOpacity(0.4),
                ),
                padding: const EdgeInsets.all(16),
                alignment: Alignment.bottomLeft,
                child: const Text(
                  'Discover Sustainable Living',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Horizontal Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text('Learning Categories',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Container(
              height: 100,
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _categoryCard(context, Icons.article, 'Articles', ArticlesScreen()),
                  const SizedBox(width: 12),
                  _categoryCard(context, Icons.play_circle_fill, 'Videos', VideosScreen()),
                  const SizedBox(width: 12),
                  _categoryCard(context, Icons.lightbulb, 'Quick Tips', QuickTipsScreen()),
                ],
              ),
            ),

            // Vertical List of Topics
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text('Popular Topics',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: popularTopics.length,
              itemBuilder: (context, index) {
                final topic = popularTopics[index];
                return _topicCard(topic['title']!, topic['desc']!);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryCard(BuildContext context, IconData icon, String label, Widget screen) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => screen),
      ),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: Colors.green[800]),
            const SizedBox(height: 8),
            Text(label,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _topicCard(String title, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(desc, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        ],
      ),
    );
  }
}
