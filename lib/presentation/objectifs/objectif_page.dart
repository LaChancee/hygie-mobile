import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/header.dart';

import 'progression_page';

class ObjectifsPage extends StatefulWidget {
  @override
  _ObjectifsPageState createState() => _ObjectifsPageState();
}

class _ObjectifsPageState extends State<ObjectifsPage> {
  // Variables pour gérer l'affichage des sous-menus
  bool showHealthGoals = false;
  bool showSavingsGoals = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Header(title: "",),
            SizedBox(height: 20),

            // Rubrique Objectifs de santé
            _buildExpandableTile(
              title: 'Objectifs de santé',
              expanded: showHealthGoals,
              onTap: () {
                setState(() {
                  showHealthGoals = !showHealthGoals;
                });
              },
              subOptions: showHealthGoals
                  ? [
                      _buildSubOption(context, 'Alcool', 'Alcool'),
                      _buildSubOption(context, 'Tabac', 'Tabac'),
                    ]
                  : [],
            ),
            SizedBox(height: 20),

            // Rubrique Objectifs d'épargne
            _buildExpandableTile(
              title: 'Objectifs d\'épargne',
              expanded: showSavingsGoals,
              onTap: () {
                setState(() {
                  showSavingsGoals = !showSavingsGoals;
                });
              },
              subOptions: showSavingsGoals
                  ? [
                      _buildSubOption(context, 'Alcool', 'Alcool'),
                      _buildSubOption(context, 'Tabac', 'Tabac'),
                    ]
                  : [],
            ),
            SizedBox(height: 20),

            // Rubrique Se fixer un objectif
            _buildSimpleTile('Se fixer un objectif', Icons.add, () {
              // Action pour créer un objectif personnalisé
            }),
          ],
        ),
      ),
    );
  }

  // Widget pour les rubriques dépliables
  Widget _buildExpandableTile({
    required String title,
    required bool expanded,
    required VoidCallback onTap,
    required List<Widget> subOptions,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(expanded ? Icons.expand_less : Icons.expand_more),
          onTap: onTap,
        ),
        if (expanded) ...subOptions,
      ],
    );
  }

  // Widget pour les sous-options (Alcool, Tabac)
  Widget _buildSubOption(BuildContext context, String label, String type) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: ListTile(
        title: Text(label),
        onTap: () {
          // Naviguer vers une page de progression pour Alcool ou Tabac
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProgressionPage(type: type)),
          );
        },
      ),
    );
  }

  // Widget pour une simple rubrique (comme "Se fixer un objectif")
  Widget _buildSimpleTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(icon),
      onTap: onTap,
    );
  }
}
