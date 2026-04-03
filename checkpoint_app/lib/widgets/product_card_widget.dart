import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCardWidget extends StatelessWidget {
  final String url;
  final String titulo;
  final String preco;

  const ProductCardWidget({
    super.key,
    required this.url,
    required this.titulo,
    required this.preco,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: const Color(0xFFF5F5F5),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              url,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: GoogleFonts.orbitron(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'R\$ $preco',
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF430091),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B0BF7),
                    minimumSize: const Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Adicionar ao carrinho',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  final List<Map<String, String>> products = const [
    {'titulo': 'Penico do Wolverine', 'preco': '170,00', 'url': 'https://placehold.co/600x600/png'},
    {'titulo': 'Máscara do Batman', 'preco': '85,50', 'url': 'https://placehold.co/600x600/png'},
    {'titulo': 'Escudo do Capitão', 'preco': '250,00', 'url': 'https://placehold.co/600x600/png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: products.map((product) => ProductCardWidget(
        titulo: product['titulo']!,
        preco: product['preco']!,
        url: product['url']!,
      )).toList(),
    );
  }
}