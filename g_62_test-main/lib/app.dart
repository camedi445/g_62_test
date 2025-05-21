import 'package:flutter/material.dart';
import 'package:g_62_test/views/main_menu_screen.dart'; 


class MainApp extends StatelessWidget {
  const MainApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Pokemon taller',
      theme: ThemeData(
        primarySwatch: Colors.red, 
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', 
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.redAccent, 
          foregroundColor: Colors.white,
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), 
          ),
          elevation: 4,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, 
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), 
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const MainMenuScreen(), 
    );
  }
}