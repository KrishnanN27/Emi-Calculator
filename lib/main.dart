import 'package:emi_calculator/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/app_home_screen.dart';
import 'Screens/onboarding_screen.dart';

// It means that it will show the onboard screen first
bool showHome = true;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  showHome = prefs.getBool('showHome') ?? true;


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: Mythemes.lightTheme,
      darkTheme: Mythemes.darkTheme,
      debugShowCheckedModeBanner: false,
      home: showHome? OnBoardingScreen() : AppHomeScreen(),
    );
  }
}

