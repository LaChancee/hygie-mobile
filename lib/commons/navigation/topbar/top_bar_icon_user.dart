import 'package:flutter/material.dart';

class TopBarWithBlueIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white, // Fond blanc
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Ombre légère
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icône bleue à gauche
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: ShapeDecoration(
                  color: Colors.blue, // Fond bleu
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Bord arrondi
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back, // Icône de votre choix
                    color: Colors.white, // Couleur de l'icône
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 8), // Espacement entre l'icône et le contenu (si nécessaire)

            ],
          ),
          // Bouton ou icône à droite
          Container(
            width: 32,
            height: 32,
            decoration: ShapeDecoration(
              color: Color(0xFF808080), // Couleur grise
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(124),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x14222222),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.more_vert, // Exemple d'icône (menu)
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Column(
        children: [
          TopBarWithBlueIcon(),
        ],
      ),
    ),
  ));
}
