import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'carbon_tracker_screen.dart';
import 'waste_tracker_screen.dart';
import 'recipes_screen.dart';
import 'energy_tips_screen.dart';
import 'eco_travel_screen.dart';
import 'profileviewscreen.dart';
import 'challenges_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int activeDays = 1;
  double totalCo2Saved = 0.0;

  String userName = 'Ibrahim Jawed';
  String? profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadActiveDays();
    _loadTotalCo2Saved();
    _loadProfileInfo();
  }

  Future<void> _loadProfileInfo() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      userName = prefs.getString('user_name') ?? 'Ibrahim Jawed';
      final imagePath = prefs.getString('user_image');
      profileImagePath = (imagePath != null && imagePath.isNotEmpty) ? imagePath : null;
    });
  }

  void _loadActiveDays() async {
    final prefs = await SharedPreferences.getInstance();
    String? startDateString = prefs.getString('start_date');
    String? lastUpdateString = prefs.getString('last_updated_date');
    DateTime now = DateTime.now();

    if (startDateString == null) {
      await prefs.setString('start_date', now.toIso8601String());
      await prefs.setString('last_updated_date', now.toIso8601String());
      if (!mounted) return;
      setState(() => activeDays = 1);
    } else {
      DateTime startDate = DateTime.parse(startDateString);
      DateTime lastUpdatedDate = lastUpdateString != null
          ? DateTime.parse(lastUpdateString)
          : startDate;

      int totalDays = now.difference(startDate).inDays + 1;

      bool shouldUpdate = now.difference(lastUpdatedDate).inHours >= 24 ||
          now.day != lastUpdatedDate.day;

      if (shouldUpdate) {
        await prefs.setString('last_updated_date', now.toIso8601String());
      }

      if (!mounted) return;
      setState(() => activeDays = totalDays);
    }
  }

  void _loadTotalCo2Saved() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() => totalCo2Saved = prefs.getDouble('latest_co2_saved') ?? 0.0);
  }

  Future<void> _navigateToProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProfileViewScreen()),
    );
    if (result == true) {
      _loadProfileInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth =
        ((MediaQuery.of(context).size.width - 48.w).clamp(0, double.infinity)) / 2;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              decoration: const BoxDecoration(color: Colors.green),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              margin: EdgeInsets.only(bottom: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, $userName",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Let’s live sustainably today!",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.green.shade100,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _navigateToProfile,
                    child: Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.orange, width: 4.w),
                      ),
                      child: ClipOval(
                        child: (profileImagePath != null && profileImagePath!.isNotEmpty)
                            ? Image.asset(profileImagePath!, fit: BoxFit.cover)
                            : Container(
                                color: Colors.white,
                                alignment: Alignment.center,
                                child: Icon(Icons.person,
                                    color: Colors.green, size: 30.sp),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 12.w,
                      runSpacing: 12.h,
                      children: [
                        SizedBox(
                          width: cardWidth,
                          child: _statCard(
                            'CO₂ Saved',
                            '${totalCo2Saved.toStringAsFixed(2)}kg',
                            Icons.cloud,
                            Colors.teal,
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: _statCard(
                            'Active Days',
                            '$activeDays',
                            Icons.calendar_today,
                            Colors.orange,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),
                    Text("Explore",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10.h),

                    GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12.h,
                          crossAxisSpacing: 12.w),
                      children: [
                        _menuIcon(Icons.track_changes, 'Tracker',
                            const CarbonTrackerScreen()),
                        _menuIcon(Icons.recycling, 'Waste',
                            const WasteTrackerScreen()),
                        _menuIcon(Icons.restaurant, 'Recipes', RecipesScreen()),
                        _menuIcon(Icons.lightbulb, 'Tips', EnergyTipsScreen()),
                        _menuIcon(Icons.flag, 'Challenges', ChallengesScreen()),
                        _menuIcon(Icons.map, 'Eco Travel', EcoTravelScreen()),
                      ],
                    ),

                    SizedBox(height: 30.h),
                    Text("🌍 Daily Eco Tips",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 150.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _ecoTips.length,
                        itemBuilder: (context, index) {
                          final tip = _ecoTips[index];
                          return _ecoTipCard(
                              tip['icon']!, tip['title']!, tip['description']!);
                        },
                      ),
                    ),

                    SizedBox(height: 30.h),
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.eco, color: Colors.green, size: 22.sp),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              '“Small acts, when multiplied by millions of people, can transform the world.”',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3)],
      ),
      child: Column(
        children: [
          Icon(icon, size: 28.sp, color: color),
          SizedBox(height: 8.h),
          Text(value,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          Text(title,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey[700])),
        ],
      ),
    );
  }

  Widget _menuIcon(IconData icon, String label, Widget targetScreen) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (_) => targetScreen));
        _loadTotalCo2Saved();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28.sp, color: Colors.green),
            SizedBox(height: 8.h),
            Text(label, style: TextStyle(fontSize: 12.sp)),
          ],
        ),
      ),
    );
  }

  final List<Map<String, String>> _ecoTips = [
    {'icon': '💧', 'title': 'Save Water', 'description': 'Turn off taps when not in use.'},
    {'icon': '🚶', 'title': 'Walk More', 'description': 'Use your feet instead of a car for short trips.'},
    {'icon': '🛒', 'title': 'Eco Shopping', 'description': 'Buy reusable bags and containers.'},
    {'icon': '🌱', 'title': 'Plant Trees', 'description': 'Every tree counts towards a greener planet.'},
  ];

  Widget _ecoTipCard(String emoji, String title, String desc) {
    return Container(
      width: 220.w,
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: TextStyle(fontSize: 28.sp)),
          SizedBox(height: 8.h),
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
          SizedBox(height: 4.h),
          Text(desc, style: TextStyle(fontSize: 12.sp)),
        ],
      ),
    );
  }
}
