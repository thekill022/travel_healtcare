import 'package:flutter/material.dart';
import 'package:travel_healthcare/homenavbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Healthcare',
      theme: ThemeData(
        appBarTheme:
            const AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeNavbarPage(),
    );
  }
}
