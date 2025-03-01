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
      backgroundColor: Color(0xFFF5F8FC),
      body: SafeArea(
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
    );
  }
}
