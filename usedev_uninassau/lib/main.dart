import 'package:flutter/material.dart';
import 'package:usedev_uninassau/src/screens/initial_screen.dart';
import 'package:usedev_uninassau/src/services/cart_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CartScope(
      notifier: CartService.instance,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UseDev',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const InitialScreen(),
      ),
    );
  }
}
