import 'package:flutter/material.dart';
import 'screens/dashboard_page.dart';
import 'screens/login_page.dart';
import 'screens/video_page.dart';

// Entry point of every Dart / Flutter program.
void main() {
  runApp(const PortfolioApp());
}

// StatelessWidget: the root widget never changes its own data.
class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ColorScheme.fromSeed creates a full matching palette from ONE colour.
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF3949AB), // indigo
    );

    return MaterialApp(
      title: 'My Portfolio',
      debugShowCheckedModeBanner: false,

      // THEME: colours/styles are defined once here and reused everywhere.
      theme: ThemeData(
        useMaterial3: true, // Material 3 design
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFFF4F5FB),
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          centerTitle: true,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),

      // NAMED ROUTES: each screen has a string name.
      // Navigator.pushReplacementNamed(context, '/dashboard') uses this map.
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/video': (context) => const VideoPage(),
      },
    );
  }
}
