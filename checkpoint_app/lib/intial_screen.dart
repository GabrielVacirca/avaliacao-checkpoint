import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Importe seus widgets aqui (exemplo):
// import 'package:seu_projeto/widgets/product_card_widget.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: const [
          Icon(Icons.person_outline, size: 30),
          SizedBox(width: 15),
          Icon(Icons.shopping_cart_outlined, size: 30),
          SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Aqui iria o seu HeroSectionWidget() que já deve estar pronto
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Promos Especiais',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.orbitron().fontFamily,
                ),
              ),
            ),

            // Exemplo de uso do card de produto
            const ProductCardWidget(
              url: 'https://placeholder.co/600x600.png',
              nome: 'Mochila do Ben10',
              preco: '200,00',
            ),

            const ProductCardWidget(
              url: 'https://placeholder.co/600x600.png',
              nome: 'Penico do Wolverine',
              preco: '170,00',
            ),

            const SubscriptionSectionWidget(),
          ],
        ),
      ),
    );
  }
}