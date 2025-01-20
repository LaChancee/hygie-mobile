import 'package:flutter/material.dart';

class TopBarCustomizable extends StatelessWidget {
  final String text;
  final Widget leftIcon;
  final Widget? rightIcon; // Icône optionnelle à droite

  const TopBarCustomizable({
    super.key,
    required this.text,
    required this.leftIcon,
    this.rightIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white, // Fond blanc
        boxShadow: [
          BoxShadow(
            color: Colors.grey, // Ombre légère
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espacement entre les icônes gauche et droite
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icône à gauche
          Container(
            width: 32,
            height: 32,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // Coins arrondis
              ),
            ),
            child: Center(
              child: leftIcon, // Icône gauche
            ),
          ),

          // Texte centré
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF222222), // Couleur du texte
              fontSize: 16,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w600,
            ),
          ),

          // Icône optionnelle à droite
          if (rightIcon != null)
            Container(
              width: 32,
              height: 32,
              child: Center(
                child: rightIcon, // Icône droite
              ),
            )
          else
            const SizedBox(width: 32), // Placeholder pour aligner les éléments
        ],
      ),
    );
  }
}

