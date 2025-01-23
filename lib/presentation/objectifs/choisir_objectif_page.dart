import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/header.dart';

class ChoisirObjectifPage extends StatelessWidget {
  final String category;

  const ChoisirObjectifPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: ""), // Utilisation du header réutilisable
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context); // Retour à la page précédente
                    },
                  ),
                  Text(
                    '$category - Objectifs',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Liste d'objectifs à choisir (en fonction de la catégorie choisie)
            _buildGoalOption('Objectif Santé 1', 'Détails de l\'objectif', Colors.blue[50]!),
            _buildGoalOption('Objectif Santé 2', 'Détails de l\'objectif', Colors.blue[50]!),
            _buildGoalOption('Objectif Épargne 1', 'Détails de l\'objectif', Colors.green[50]!),
            _buildGoalOption('Objectif Épargne 2', 'Détails de l\'objectif', Colors.green[50]!),
            // Ajouter plus d'objectifs selon la catégorie
          ],
        ),
      ),
    );
  }

  // Widget pour afficher chaque objectif dans la liste
  Widget _buildGoalOption(String title, String subtitle, Color backgroundColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: backgroundColor,
        elevation: 0, 
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          onTap: () {
            // Naviguer vers la page de progression ou un autre écran
            // Cela peut être modifié selon ce que vous souhaitez faire après la sélection d'un objectif
          },
        ),
      ),
    );
  }
}
