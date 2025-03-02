import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/header.dart';
import 'package:hygie_mobile/presentation/objectifs/progression_page.dart';
import 'package:hygie_mobile/services/app_router.dart';

class ChoisirObjectifPage extends StatelessWidget {
  final String category;

  const ChoisirObjectifPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      AppRouter().goBack(
                          context); // Utiliser AppRouter pour revenir en arrière
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

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Liste d'objectifs à choisir (en fonction de la catégorie choisie)
                    _buildGoalOption(context, 'Objectif Santé 1',
                        'Détails de l\'objectif', Colors.blue[50]!),
                    _buildGoalOption(context, 'Objectif Santé 2',
                        'Détails de l\'objectif', Colors.blue[50]!),
                    _buildGoalOption(context, 'Objectif Épargne 1',
                        'Détails de l\'objectif', Colors.green[50]!),
                    _buildGoalOption(context, 'Objectif Épargne 2',
                        'Détails de l\'objectif', Colors.green[50]!),
                    // Ajouter plus d'objectifs selon la catégorie
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour afficher chaque objectif dans la liste
  Widget _buildGoalOption(BuildContext context, String title, String subtitle,
      Color backgroundColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: backgroundColor,
        elevation: 0,
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          onTap: () {
            // Utiliser AppRouter pour naviguer tout en gardant la barre de navigation
            AppRouter().navigateTo(context, ProgressionPage(type: title));
          },
        ),
      ),
    );
  }
}
