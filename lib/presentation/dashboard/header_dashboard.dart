import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/ui/colors.dart';

class HeaderDashboard extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/hygie_background.png'),
              fit: BoxFit.cover, // Ajuste l'image à la taille de l'espace
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          // Ajoute du padding horizontal et vertical
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              // Espace supplémentaire en haut
              Text(
                'Non-fumeur depuis :',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center, // Texte centré
              ),
              SizedBox(height: 5),
              Text(
                '2 jours',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center, // Texte centré
              ),
              SizedBox(height: 40),
              // Espace supplémentaire entre le texte et les boutons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: _buildActionButton('Consommation'),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: _buildBilanButton('Bilan'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              // Espace en bas du header
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label) {
    return ElevatedButton(
      onPressed: () {
        // Ajoute ici l'action du bouton
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor, // Couleur de fond du bouton
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Coins arrondis
        ),
      ),
      child: Text(label, style: TextStyle(fontSize: 16)),
    );
  }

  Widget _buildBilanButton(String label) {
    return ElevatedButton(
      onPressed: () {
        // Ajoute ici l'action du bouton
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.2), // Couleur de fond avec transparence
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Coins arrondis
          side: BorderSide(color: Colors.white, width: 2), // Bordure blanche
        ),
      ),
      child: Text(label, style: TextStyle(fontSize: 16)),
    );
  }
}
