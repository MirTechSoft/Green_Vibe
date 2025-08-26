// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'login_screen.dart';
// import 'main_drawer_app.dart';

// class SplashScreen extends StatefulWidget {
//   final bool isLoggedIn;
//   const SplashScreen({super.key, required this.isLoggedIn});

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 4), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) =>
//               widget.isLoggedIn ? const MainDrawerApp() : const LoginScreen(),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 250, 255, 245), // same as native splash
//       body: Center(
//         child: Image.asset(
//           'assets/images/logo.png',
//           width: 150,
//           height: 150,
//         ),
//       ),
//     );
//   }
// }

