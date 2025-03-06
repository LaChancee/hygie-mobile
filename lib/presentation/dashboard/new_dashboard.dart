import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/dashboard/context_card.dart';
import 'package:hygie_mobile/presentation/dashboard/dasboard_content.dart';
import 'package:hygie_mobile/presentation/dashboard/top_bar.dart';

class NewDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F7FA), // Bleu clair
              Color(0xFFE8F5E9), // Vert clair
              Color(0xFFF3E5F5), // Violet clair
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          bottom: false, // Ne pas ajouter de marge en bas
          child: Column(
            children: [
              // TopBar (Barre supérieure)
              TopBar(),

              // Contenu principal
              Expanded(
                child: Column(
                  children: [
                    // CardsContext (Carte avec les jours sans fumer)
                    CardsContext(),

                    // ContentsDashboard (Widgets du Dashboard)
                    Expanded(
                      child: ContentsDashboard(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
