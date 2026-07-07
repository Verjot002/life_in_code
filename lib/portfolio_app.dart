import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verjot Heer | Flutter Developer Portfolio',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF07090E), // Deep tech obsidian
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF64FFDA), // Neon cyan
          secondary: Color(0xFFBD00FF), // Neon purple
          surface: Color(0xFF131824), // Glassy dark card
          background: Color(0xFF07090E),
          onPrimary: Color(0xFF07090E),
          onSecondary: Colors.white,
          onSurface: Color(0xFFECEFF4),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.0,
            color: Colors.white,
          ),
          displayMedium: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color(0xFF64FFDA),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: Color(0xFF909BB4),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: Color(0xFF909BB4),
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF131824),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(
              color: Color(0xFF202B3E),
              width: 1,
            ),
          ),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
