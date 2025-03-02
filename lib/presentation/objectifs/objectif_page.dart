import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/header.dart';
import 'package:hygie_mobile/presentation/objectifs/progression_page.dart';
import 'package:hygie_mobile/presentation/objectifs/choisir_objectif_page.dart';
import 'package:hygie_mobile/services/app_router.dart';

class ObjectifsPage extends StatefulWidget {
  @override
  _ObjectifsPageState createState() => _ObjectifsPageState();
}

class _ObjectifsPageState extends State<ObjectifsPage> {
  bool showHealthGoals = false;
  bool showSavingsGoals = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Header(title: ""),
            SizedBox(height: 20),

            // Contenu principal dans un SingleChildScrollView
            Expanded(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rubrique Objectifs de santé
                    _buildGoalSection(
                      title: 'Objectif de santé',
                      icon: Icons.local_fire_department,
                      expanded: showHealthGoals,
                      onTap: () {
                        setState(() {
                          showHealthGoals = !showHealthGoals;
                        });
                      },
                      subOptions: showHealthGoals
                          ? [
                              _buildSubOption(
                                  context,
                                  'Tabac',
                                  'Objectifs validés 2/46',
                                  'Tabac',
                                  Colors.blue[50]!),
                              SizedBox(
                                  height: 10), // Espace entre Tabac et Alcool
                              _buildSubOption(
                                  context,
                                  'Alcool',
                                  'Objectifs validés 1/10',
                                  'Alcool',
                                  Colors.blue[50]!),
                              SizedBox(
                                  height:
                                      20), // Espacement ajouté en dessous de la carte Alcool
                            ]
                          : [],
                    ),
                    SizedBox(height: 20),

                    // Rubrique Objectifs d'épargne avec les mêmes espacements
                    _buildGoalSection(
                      title: 'Objectif d\'épargne',
                      icon: Icons.savings,
                      expanded: showSavingsGoals,
                      onTap: () {
                        setState(() {
                          showSavingsGoals = !showSavingsGoals;
                        });
                      },
                      subOptions: showSavingsGoals
                          ? [
                              _buildSubOption(
                                  context,
                                  'Tabac',
                                  'Objectifs validés 2/46',
                                  'Tabac',
                                  Colors.blue[50]!),
                              SizedBox(
                                  height: 10), // Espace entre Tabac et Alcool
                              _buildSubOption(
                                  context,
                                  'Alcool',
                                  'Objectifs validés 1/10',
                                  'Alcool',
                                  Colors.blue[50]!),
                              SizedBox(
                                  height:
                                      20), // Espacement ajouté en dessous de la carte Alcool pour épargne
                            ]
                          : [],
                    ),
                    SizedBox(height: 20),

                    // Rubrique Se fixer un objectif
                    _buildSimpleTile('Se fixer un objectif', Icons.add),

                    // Espace en bas pour éviter que le contenu soit caché par la TabBar
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour les rubriques d'objectif avec icône et options
  Widget _buildGoalSection({
    required String title,
    required IconData icon,
    required bool expanded,
    required VoidCallback onTap,
    required List<Widget> subOptions,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 0, // Suppression de l'ancienne élévation
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Ombrage léger et discret
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              ListTile(
                leading: Icon(icon, color: Color.fromRGBO(4, 75, 217, 1)),
                title: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing:
                    Icon(expanded ? Icons.expand_less : Icons.expand_more),
                onTap: onTap,
              ),
              if (expanded) ...subOptions,
            ],
          ),
        ),
      ),
    );
  }

  // Widget pour les sous-options (Tabac, Alcool) sans ombrage
  Widget _buildSubOption(BuildContext context, String label, String subtitle,
      String type, Color backgroundColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: backgroundColor, // Couleur de fond uniforme
        elevation: 0, // Suppression de l'ombrage pour les sous-options
        child: ListTile(
          title: Text(label),
          subtitle: Text(subtitle),
          onTap: () {
            // Utiliser AppRouter pour naviguer tout en gardant la barre de navigation
            AppRouter().navigateTo(context, ProgressionPage(type: type));
          },
        ),
      ),
    );
  }

  // Widget pour une simple rubrique (comme "Se fixer un objectif") avec ombrage discret
  Widget _buildSimpleTile(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 0, // Suppression de l'ancienne élévation
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Ombrage léger
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: ListTile(
            leading: Icon(icon, color: Colors.black),
            title: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Utiliser AppRouter pour naviguer tout en gardant la barre de navigation
              AppRouter().navigateTo(context,
                  ChoisirObjectifPage(category: 'Choisir un objectif'));
            },
          ),
        ),
      ),
    );
  }
}
