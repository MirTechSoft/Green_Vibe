import 'package:flutter/material.dart';
import 'post_detail_screen.dart';

class CommunityScreen extends StatelessWidget {
  final List<Map<String, dynamic>> posts = [
    {
      'user': 'EcoWarrior01',
      'title': 'Best tips to reduce plastic use?',
      'desc': 'Looking for practical ideas for everyday plastic reduction.',
      'time': '2 hours ago',
      'comments': 4,
    },
    {
      'user': 'GreenGuru',
      'title': 'How to compost in a small apartment?',
      'desc': 'I live in an apartment, curious how composting can work.',
      'time': '5 hours ago',
      'comments': 7,
    },
    {
      'user': 'SustainLife',
      'title': 'Affordable eco-friendly products?',
      'desc': 'Share where you buy budget-friendly green products.',
      'time': '1 day ago',
      'comments': 10,
    },
  ];

  CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        elevation: 0,
        title: Text('Community Forum'),
        titleTextStyle: TextStyle(
          color: Colors.white, // Heading ka color white
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return _buildPostCard(context, post);
        },
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, Map<String, dynamic> post) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User + Time
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green.shade200,
                child: Icon(Icons.person, color: Colors.white),
              ),
              SizedBox(width: 10),
              Text(post['user'], style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text(post['time'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            ],
          ),
          SizedBox(height: 12),

          // Title
          Text(post['title'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),

          // Description
          Text(post['desc'],
              style: TextStyle(fontSize: 14, color: Colors.grey[700])),

          SizedBox(height: 12),

          // Comments and Reply Button
          Row(
            children: [
              Icon(Icons.comment, size: 18, color: Colors.grey[600]),
              SizedBox(width: 6),
              Text('${post['comments']} replies',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600])),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PostDetailScreen(
                        title: post['title'],
                        user: post['user'],
                        time: post['time'],
                        description: post['desc'],
                      ),
                    ),
                  );
                },
                child: Text('Reply'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
