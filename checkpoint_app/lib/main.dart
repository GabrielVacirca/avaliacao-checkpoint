import 'package:flutter/material.dart';
// Importe a sua tela inicial aqui. 
// O caminho depende de onde você salvou o arquivo:
import 'package:seu_projeto/src/screens/initial_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UseDev App',
      debugShowCheckedModeBanner: false, // Remove a faixa de "debug" do canto
      theme: ThemeData(
        // Configuração básica de cores para combinar com o design
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7B0BF7), // O roxo principal
          brightness: Brightness.light, 
        ),
        useMaterial3: true,
      ),
      // Aqui você define qual tela abre primeiro
      home: const InitialScreen(), 
    );
  }
}