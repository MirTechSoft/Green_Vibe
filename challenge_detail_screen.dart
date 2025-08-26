import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChallengeDetailScreen extends StatefulWidget {
  final Map<String, dynamic> challenge;

  const ChallengeDetailScreen({super.key, required this.challenge});

  @override
  State<ChallengeDetailScreen> createState() => _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends State<ChallengeDetailScreen> {
  late List<String> tasks;
  late List<bool> completed;
  int pointsEarned = 0;
  Duration? timeLeft;
  bool challengeLocked = false;
  bool userPressedComplete = false;

  @override
  void initState() {
    super.initState();

    // Load tasks from the passed challenge data; fallback to empty list if missing
    tasks = List<String>.from(widget.challenge['tasks'] ?? []);

    // Initialize completed list with false for each task
    completed = List<bool>.filled(tasks.length, false);

    _loadProgress();
    _checkChallengeAvailability();
  }

  Future<void> saveJoinTime(String challengeId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('join_time_$challengeId', DateTime.now().toIso8601String());
  }

  Future<Duration?> getElapsedTime(String challengeId) async {
    final prefs = await SharedPreferences.getInstance();
    final joinTimeStr = prefs.getString('join_time_$challengeId');
    if (joinTimeStr == null) return null;

    final joinTime = DateTime.parse(joinTimeStr);
    return DateTime.now().difference(joinTime);
  }

  Future<void> _checkChallengeAvailability() async {
    final id = widget.challenge['title'];
    final elapsed = await getElapsedTime(id);

    if (elapsed != null && elapsed < const Duration(hours: 24)) {
      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getStringList('completed_$id');

      final allTasksDone = stored != null && stored.every((s) => s == 'true');

      if (allTasksDone) {
        setState(() {
          challengeLocked = true;
          timeLeft = const Duration(hours: 24) - elapsed;
        });
        _startCountdown();
      } else {
        await _clearJoinTime(); // Incomplete data? Remove join time
      }
    } else if (elapsed != null && elapsed >= const Duration(hours: 24)) {
      await _clearJoinTime();
      await _clearProgress();
      setState(() {
        completed = List<bool>.filled(tasks.length, false);
        challengeLocked = false;
        timeLeft = null;
      });
    } else {
      setState(() {
        challengeLocked = false;
        timeLeft = null;
      });
    }
  }

  void _startCountdown() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;

      setState(() {
        if (timeLeft != null) {
          timeLeft = timeLeft! - const Duration(seconds: 1);
          if (timeLeft!.inSeconds <= 0) {
            challengeLocked = false;
            timeLeft = null;
            _clearJoinTime();
            _clearProgress();
            completed = List<bool>.filled(tasks.length, false);
          }
        }
      });

      return challengeLocked;
    });
  }

  Widget buildCountdown(Duration remaining) {
    final hours = remaining.inHours;
    final minutes = remaining.inMinutes % 60;
    final seconds = remaining.inSeconds % 60;

    return Text(
      "Next challenge in: $hours h $minutes m $seconds s",
      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    );
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final id = widget.challenge['title'];
    prefs.setStringList('completed_$id', completed.map((c) => c.toString()).toList());
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final id = widget.challenge['title'];
    final stored = prefs.getStringList('completed_$id');
    if (stored != null && stored.length == tasks.length) {
      setState(() {
        completed = stored.map((s) => s == 'true').toList();
      });
    }
  }

  Future<void> _clearJoinTime() async {
    final prefs = await SharedPreferences.getInstance();
    final id = widget.challenge['title'];
    prefs.remove('join_time_$id');
  }

  Future<void> _clearProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final id = widget.challenge['title'];
    prefs.remove('completed_$id');
  }

  void markAsCompleted() async {
    if (completed.every((c) => c)) {
      final id = widget.challenge['title'];
      userPressedComplete = true;

      await saveJoinTime(id);
      await _saveProgress();

      setState(() {
        pointsEarned = tasks.length * 10;
        challengeLocked = true;
        timeLeft = const Duration(hours: 24);
      });

      _startCountdown();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Challenge completed! You earned $pointsEarned GreenPoints!'),
          backgroundColor: Colors.green,
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Complete all tasks to finish this challenge!'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final challenge = widget.challenge;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          challenge['title'],
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                challenge['icon'],
                style: const TextStyle(fontSize: 50),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              challenge['title'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Text(
              challenge['description'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            const Text(
              '🕒 Complete within 1 Day',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            if (challengeLocked && timeLeft != null) ...[
              const SizedBox(height: 8),
              buildCountdown(timeLeft!),
              const SizedBox(height: 8),
              const Text(
                "You’ve already completed this challenge. Wait for 24 hours to restart.",
                style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
              ),
            ],

            const SizedBox(height: 16),

            const Text(
              '✅ Your Tasks:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            ...List.generate(tasks.length, (index) {
              return CheckboxListTile(
                title: Text(tasks[index]),
                value: completed[index],
                activeColor: Colors.green,
                onChanged: (value) {
                  if (!challengeLocked) {
                    setState(() {
                      completed[index] = value!;
                    });
                    _saveProgress();
                  }
                },
              );
            }),

            const Spacer(),

            ElevatedButton.icon(
              onPressed: challengeLocked ? null : markAsCompleted,
              icon: const Icon(Icons.check_circle),
              label: const Text("Mark as Completed"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white, // Text and icon color white
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
