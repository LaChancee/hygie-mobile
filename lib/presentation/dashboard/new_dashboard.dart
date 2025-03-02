import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/dashboard/context_card.dart';
import 'package:hygie_mobile/presentation/dashboard/dasboard_content.dart';
import 'package:hygie_mobile/presentation/dashboard/tapbar.dart';
import 'package:hygie_mobile/presentation/dashboard/top_bar.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
              // ✅ TopBar (Barre supérieure)
              TopBar(),

              // ✅ ESPACE PRINCIPAL : Dashboard Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.02),

                      // ✅ CardsContext (Carte avec les jours sans fumer)
                      CardsContext(),

                      SizedBox(height: screenHeight * 0.03),

                      // ✅ ContentsDashboard (Widgets du Dashboard)
                      ContentsDashboard(),
                    ],
                  ),
                ),
              ),

              // ✅ TabBar (Barre de navigation en bas)
              ResponsiveTabBar(),
            ],
          ),
        ),
      ),
    );
  }
}
