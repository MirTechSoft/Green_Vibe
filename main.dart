import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FontSizeProvider.dart';

// Screens
import 'screens/dashboard_screen.dart';
import 'screens/carbon_tracker_screen.dart';
import 'screens/product_suggestions_screen.dart';
import 'screens/challenges_screen.dart';
import 'screens/certifications_screen.dart';
import 'screens/waste_tracker_screen.dart';
import 'screens/recipes_screen.dart';
import 'screens/energy_tips_screen.dart';
import 'screens/eco_travel_screen.dart';
import 'screens/community_screen.dart';
import 'screens/educational_content_screen.dart';
import 'screens/about_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/settings_screen.dart';

// Login & Signup
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
// ❌ splash_screen.dart import hata diya

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (_) => FontSizeProvider(),
      child: SustainableApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class SustainableApp extends StatelessWidget {
  final bool isLoggedIn;
  const SustainableApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return Consumer<FontSizeProvider>(
      builder: (context, fontSizeProvider, child) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              title: 'Sustainable Living App',
              theme: ThemeData(
                primarySwatch: Colors.green,
                textTheme: Theme.of(context).textTheme.apply(
                      fontSizeFactor: fontSizeProvider.fontSizeValue / 18.0,
                    ),
              ),
              debugShowCheckedModeBanner: false,

              // ✅ direct navigation after native splash
              home: isLoggedIn ? const MainDrawerApp() : const LoginScreen(),

              routes: {
                '/login': (context) => const LoginScreen(),
                '/signup': (context) => const SignupScreen(),
                '/dashboard': (context) => const MainDrawerApp(),
              },
            );
          },
        );
      },
    );
  }
}

// ==================== MainDrawerApp class remains same =====================
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
    WasteTrackerScreen(),
    ChallengesScreen(),
    EcoTravelScreen(),
    RecipesScreen(),
    ProductSuggestionsScreen(),
    EducationalContentScreen(),
    EnergyTipsScreen(),
    CommunityScreen(),
    CertificationsScreen(),
    AboutScreen(),
    ContactScreen(),
    SettingsScreen(),
    // ❌ Logout ke liye koi screen add nahi karni
  ];

  final List<String> _screenTitles = [
    'Dashboard',
    'Carbon Footprint Tracker',
    'Waste Reduction Tracker',
    'Sustainable Challenges',
    'Eco Travel',
    'Sustainable Recipes',
    'Eco-Friendly Products',
    'Educational Content',
    'Energy Tips',
    'Community Forum',
    'Green Certifications',
    'About Us',
    'Contact Us',
    'Settings',
    'Logout',
  ];

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  void _onDrawerTap(int index) {
    if (_screenTitles[index] == "Logout") {
      // ✅ Direct logout
      _logout(context);
    } else {
      setState(() {
        _selectedIndex = index;
        Navigator.pop(context);
      });
    }
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
                  color: _selectedIndex == i ? const Color.fromARGB(221, 1, 131, 18) : Colors.black54,
                ),
                title: Text(
                  _screenTitles[i],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: _selectedIndex == i ? const Color.fromARGB(255, 34, 33, 33) : Colors.black87,
                    fontWeight: _selectedIndex == i
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                selected: _selectedIndex == i,
                selectedTileColor:const Color.fromARGB(255, 68, 172, 73).withOpacity(0.2),
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
       Icons.delete_outline,
       Icons.task,
      Icons.shopping_bag,
      Icons.restaurant_menu,
      Icons.travel_explore,
      Icons.menu_book,
       Icons.lightbulb,
       Icons.group,
      Icons.verified,
      Icons.info,
      Icons.contact_mail,
      Icons.settings,
      Icons.logout,
    ];
    return Icon(icons[index]);
  }
}
