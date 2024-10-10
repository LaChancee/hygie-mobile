import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/colors.dart';

class TestButton extends StatelessWidget {
  const TestButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            // Couleur de l'ombre avec transparence
            spreadRadius: 2,
            // Propage l'ombre (comme une bordure floue)
            blurRadius: 20,
            // Floutage de l'ombre
            offset: Offset(0, 3), // Déplacement de l'ombre (horizontal, vertical)
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Utilise Flexible pour éviter que le texte dépasse
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Aligne le texte à gauche
              children: [
                Text(
                  'Testez votre niveau de dépendance',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF8C5EFF),
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1, // Limite le texte à une seule ligne
                  overflow: TextOverflow
                      .ellipsis, // Ajoute "..." si le texte est trop long
                ),
                SizedBox(height: 5),
                // Ajoute un petit espace entre les deux textes
                Text(
                  'Fixez-vous des objectifs et obtenez des données plus détaillées.',
                  style: TextStyle(fontSize: 14, color: AppColors.textColor),
                  maxLines: 2,
                  // Limite à deux lignes pour la description
                  overflow: TextOverflow.ellipsis,
                  // Ajoute "..." si le texte dépasse
                  softWrap: true, // Permet au texte de passer à la ligne suivante
                ),
              ],
            ),
          ),

          // Le conteneur pour l'affichage "+20"
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              '+20',
              style: TextStyle(
                  color: Color(0xFF8C5EFF), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
