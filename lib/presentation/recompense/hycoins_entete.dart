import 'package:flutter/material.dart';

class HycoinsHeader extends StatelessWidget {
  const HycoinsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF005BEA), // Couleur de dégradé bleu foncé
              Color(0xFF00C6FB), // Couleur de dégradé bleu clair
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrer verticalement
          crossAxisAlignment: CrossAxisAlignment.center, // Centrer horizontalement
          children: [
            const Text(
              'Mes hycoins',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centrer horizontalement
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  '2145,63',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'hc',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Action du bouton Historique
              },
              icon: const Icon(Icons.history, color: Colors.white),
              label: const Text(
                'Historique',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2), // Couleur du bouton
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
