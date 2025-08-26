import 'package:flutter/material.dart';
import 'challenge_detail_screen.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  _ChallengesScreenState createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  List<Map<String, dynamic>> challenges = [
    {
      'icon': '♻️',
      'title': 'Recycle More',
      'description': 'Separate plastic, paper, and compost waste daily.',
      'joined': false,
      'tasks': [
        'Collect plastic waste',
        'Separate paper waste',
        'Compost organic waste',
        'Use recycling bins',
        'Educate family about recycling',
      ],
    },
    {
      'icon': '💧',
      'title': 'Save Water',
      'description': 'Turn off taps and take shorter showers.',
      'joined': false,
      'tasks': [
        'Turn off taps while brushing',
        'Fix leaking faucets',
        'Take shorter showers',
        'Use a bucket instead of hose',
        'Collect rainwater for plants',
      ],
    },
    {
      'icon': '🚶',
      'title': 'Walk More',
      'description': 'Walk instead of using motor transport when possible.',
      'joined': false,
      'tasks': [
        'Walk to nearby places',
        'Use stairs instead of elevator',
        'Take a daily 30-min walk',
        'Avoid short car trips',
        'Encourage family to walk',
      ],
    },
    {
      'icon': '🕌',
      'title': 'Offer Namaz',
      'description': 'Pray five times a day regularly.',
      'joined': false,
      'tasks': [
        'Pray Fajr on time',
        'Pray Dhuhr on time',
        'Pray Asr on time',
        'Pray Maghrib on time',
        'Pray Isha on time',
      ],
    },
    {
      'icon': '🥗',
      'title': 'Healthy Eating',
      'description': 'Eat more fruits, vegetables, and whole foods.',
      'joined': false,
      'tasks': [
        'Eat 5 servings of fruits',
        'Include veggies in every meal',
        'Avoid processed foods',
        'Drink enough water',
        'Limit sugary snacks',
      ],
    },
    {
      'icon': '📵',
      'title': 'Digital Detox',
      'description': 'Avoid unnecessary screen time for a day.',
      'joined': false,
      'tasks': [
        'Avoid social media for 1 day',
        'Read a book instead',
        'Go outside without phone',
        'Spend quality time with family',
        'Practice mindfulness',
      ],
    },
    {
      'icon': '🌿',
      'title': 'Plant a Tree',
      'description': 'Plant or take care of a plant every month.',
      'joined': false,
      'tasks': [
        'Buy a sapling',
        'Prepare planting spot',
        'Plant the tree properly',
        'Water regularly',
        'Protect from pests',
      ],
    },
  ];

  void toggleJoin(int index) {
    setState(() {
      challenges[index]['joined'] = true;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChallengeDetailScreen(
          challenge: challenges[index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Eco & Life Challenges',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green.shade700,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: challenges.length,
        itemBuilder: (context, index) {
          final challenge = challenges[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: challenge['joined'] ? Colors.green.shade50 : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Text(
                challenge['icon'],
                style: const TextStyle(fontSize: 30),
              ),
              title: Text(
                challenge['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  challenge['description'],
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              trailing: challenge['joined']
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.shade600,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Joined',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () => toggleJoin(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: const Text('Join'),
                    ),
            ),
          );
        },
      ),
    );
  }
}
