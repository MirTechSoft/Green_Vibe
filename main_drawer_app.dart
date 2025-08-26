import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Screens
import 'dashboard_screen.dart';
import 'carbon_tracker_screen.dart';
import 'product_suggestions_screen.dart';
import 'challenges_screen.dart';
import 'certifications_screen.dart';
import 'waste_tracker_screen.dart';
import 'recipes_screen.dart';
import 'energy_tips_screen.dart';
import 'eco_travel_screen.dart';
import 'community_screen.dart';
import 'educational_content_screen.dart';
import 'about_screen.dart';
import 'contact_screen.dart';
import 'settings_screen.dart';

class MainDrawerApp extends StatefulWidget {
  const MainDrawerApp({super.key});

  @override
  _MainDrawerAppState createState() => _MainDrawerAppState();
}

class _MainDrawerAppState extends State<MainDrawerApp> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    DashboardScreen(),
    CarbonTrackerScreen(),
    ProductSuggestionsScreen(),
    ChallengesScreen(),
    CertificationsScreen(),
    WasteTrackerScreen(),
    RecipesScreen(),
    EnergyTipsScreen(),
    EcoTravelScreen(),
    CommunityScreen(),
    EducationalContentScreen(),
    AboutScreen(),
    ContactScreen(),
    SettingsScreen(),
  ];

  final List<String> _screenTitles = [
    'Dashboard',
    'Carbon Footprint Tracker',
    'Eco-Friendly Products',
    'Sustainable Challenges',
    'Green Certifications',
    'Waste Reduction Tracker',
    'Sustainable Recipes',
    'Energy Tips',
    'Eco Travel',
    'Community Forum',
    'Educational Content',
    'About Us',
    'Contact Us',
    'Settings',
  ];

  void _onDrawerTap(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _screenTitles[_selectedIndex],
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green.shade700),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.eco, size: 40.sp, color: Colors.white),
                  SizedBox(height: 10.h),
                  Text(
                    'Sustainable App',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Live Green • Live Smart',
                    style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            for (int i = 0; i < _screenTitles.length; i++)
              ListTile(
                leading: Icon(
                  _getIconForIndex(i).icon,
                  size: 22.sp,
                  color: _selectedIndex == i ? Colors.orange : Colors.black54,
                ),
                title: Text(
                  _screenTitles[i],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: _selectedIndex == i ? Colors.orange : Colors.black87,
                    fontWeight: _selectedIndex == i
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                selected: _selectedIndex == i,
                selectedTileColor: Colors.orange.withOpacity(0.2),
                onTap: () => _onDrawerTap(i),
              ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }

  Icon _getIconForIndex(int index) {
    List<IconData> icons = [
      Icons.dashboard,
      Icons.eco,
      Icons.shopping_bag,
      Icons.task,
      Icons.verified,
      Icons.delete_outline,
      Icons.restaurant_menu,
      Icons.lightbulb,
      Icons.travel_explore,
      Icons.group,
      Icons.menu_book,
      Icons.info,
      Icons.contact_mail,
      Icons.settings,
    ];
    return Icon(icons[index]);
  }
}
