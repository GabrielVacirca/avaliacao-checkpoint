import 'package:flutter/material.dart';
import 'package:checkpoint_app/screens/intial_screen.dart'; 
import 'package:checkpoint_app/widgets/product_card_widget.dart';
import 'package:checkpoint_app/widgets/subscription_section_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UseDev',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF430091)),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        title: Image.asset('assets/Logo UseDev.png', height: 40),
        centerTitle: true,
        actions: const [
          Icon(Icons.person_outline, size: 35, color: Colors.black),
          SizedBox(width: 10),
          Icon(Icons.shopping_cart_outlined, size: 35, color: Colors.black),
          SizedBox(width: 15),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            InitialScreen(), 
            ProductListScreen(),
            SubscriptionScreen(),
          ],
        ),
      ),
    );
  }
}