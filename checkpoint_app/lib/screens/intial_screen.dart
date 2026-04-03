import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: double.infinity,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'o que você procura?',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 520,
          decoration: const BoxDecoration(
            color: Color(0xFF090129),
            image: DecorationImage(
              image: AssetImage('assets/fundo.png'),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/hero.png',
                  height: 250,
                ),
                const SizedBox(height: 10),
                Text(
                  'Hora de abraçar seu',
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: GoogleFonts.orbitron().fontFamily,
                    color: const Color(0xFFFF55DF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'lado geek!',
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: GoogleFonts.orbitron().fontFamily,
                    color: const Color(0xFF8FFF24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7B0BF7),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        'Ver novidades!',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: GoogleFonts.orbitron().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Promos especiais',
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: GoogleFonts.orbitron().fontFamily,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF7B0BF7),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}