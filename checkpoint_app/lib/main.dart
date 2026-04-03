import 'package:flutter/material.dart';
import 'package:checkpoint_app/screens/intial_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UseDev App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7B0BF7),
          brightness: Brightness.light, 
        ),
        useMaterial3: true,
      ),
      home: const InitialScreen(), 
    );
  }
}