import 'package:flutter/material.dart';

class PostDetailScreen extends StatelessWidget {
  final String title;
  final String user;
  final String time;
  final String description;

  const PostDetailScreen({
    super.key,
    required this.title,
    required this.user,
    required this.time,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: Text("Post Details"),
        titleTextStyle: TextStyle(
          color: Colors.white,  // Title text white
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.black),  // Back arrow black
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green.shade300,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 10),
                Text(user, style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                Text(time, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            SizedBox(height: 20),

            // Title
            Text(title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900])),

            SizedBox(height: 16),

            // Description
            Text(description,
                style: TextStyle(fontSize: 16, color: Colors.grey[800])),

            SizedBox(height: 30),

            Divider(),

            Text("Replies (Coming Soon...)", style: TextStyle(color: Colors.grey[600])),
            // 🔧 Later: You can add a list of comments from Firebase here
          ],
        ),
      ),
    );
  }
}
