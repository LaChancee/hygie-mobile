import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/dashboard/context_card.dart';
import 'package:hygie_mobile/presentation/dashboard/dasboard_content.dart';
import 'package:hygie_mobile/presentation/dashboard/top_bar.dart';

class NewDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          child: Column(
            children: [
              // TopBar (Barre supérieure)
              TopBar(),

              // Contenu principal
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10), // Réduit l'espace en haut

                      // CardsContext (Carte avec les jours sans fumer)
                      CardsContext(),

                      SizedBox(height: 10), // Réduit l'espace entre les cartes

                      // ContentsDashboard (Widgets du Dashboard)
                      ContentsDashboard(),

                      // Espace en bas pour éviter que le contenu soit caché par la TabBar
                      SizedBox(height: 20), // Réduit l'espace en bas
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
