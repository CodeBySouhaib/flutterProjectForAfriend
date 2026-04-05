import 'package:flutter/material.dart';
import 'package:orm_risk_assessment/ui/landing_page.dart';
import 'package:orm_risk_assessment/ui/splash_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ORM Risk Assessment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF191970),
          background: const Color(0xFF111154),
          surface: const Color(0xFF080838),
          primary: const Color(0xFF191970),
          secondary: const Color(0xFF4169E1),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF080838),
        fontFamily: 'Courier New',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFFE0E0E0)),
          titleLarge: TextStyle(
            color: Color(0xFF4169E1),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          titleMedium: TextStyle(
            color: Color(0xFF6495ED),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF191970)),
            borderRadius: BorderRadius.zero,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF191970)),
            borderRadius: BorderRadius.zero,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF4169E1)),
            borderRadius: BorderRadius.zero,
          ),
          labelStyle: TextStyle(color: Color(0xFF4169E1)),
          hintStyle: TextStyle(color: Color(0xFF888888)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF191970),
            foregroundColor: const Color(0xFFFFFFFF),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide(color: Color(0xFF4169E1)),
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              letterSpacing: 1.5,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xFF111154),
            foregroundColor: const Color(0xFFFFFFFF),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide(color: Color(0xFF191970)),
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}