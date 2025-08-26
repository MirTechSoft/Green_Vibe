import 'package:flutter/material.dart';

class VideosScreen extends StatelessWidget {
  final List<Map<String, String>> videos = [
    {
      'title': 'Sustainable Living Tips',
      'duration': '5:34',
    },
    {
      'title': 'How Solar Power Works',
      'duration': '8:21',
    },
    {
      'title': 'Zero Waste Lifestyle',
      'duration': '6:10',
    },
  ];

  VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Videos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green.shade700,
        centerTitle: true,
        elevation: 4,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.yellow.shade100,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.orange.shade800),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "This section will be updated soon with more videos and detailed content.",
                    style: TextStyle(
                      color: Colors.orange.shade800,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: videos.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final video = videos[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 3,
                  shadowColor: Colors.green.shade200,
                  child: ListTile(
                    leading: Icon(
                      Icons.play_circle_fill,
                      color: Colors.green.shade700,
                      size: 36,
                    ),
                    title: Text(
                      video['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Duration: ${video['duration']}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Play video or navigate to detail page
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
