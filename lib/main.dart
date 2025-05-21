import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_62_test/ui/navigation/router.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Pokemon App Con Malas Prácticas',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: router,
    );
  }
}
