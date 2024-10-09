import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hygie_mobile/commons/colors.dart';
import 'package:hygie_mobile/commons/header.dart';
import 'package:hygie_mobile/presentation/dashboard/header_dashboard.dart'; // Assurez-vous que le chemin est correct
import 'package:hygie_mobile/presentation/dashboard/test_button.dart'; // Assurez-vous que le chemin est correct
import 'package:hygie_mobile/presentation/dashboard/widget_dashboard.dart'; // Assurez-vous que le chemin est correct



class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar, qui se rétrécit au scroll
          SliverAppBar(
            title: Header(title: '',),
            expandedHeight: 300.0, // Hauteur de l'expansion
            floating: false, // Le header ne flotte pas au-dessus
            pinned: true, // Le header reste visible quand on scrolle
            flexibleSpace: FlexibleSpaceBar(
              background: HeaderDashboard(),
              centerTitle: true,
            ),
          ),

          // Contenu principal avec coins arrondis en haut
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(left: 0, right: 0, top: 0),
              // Supprime le margin pour toucher les bords
              decoration: BoxDecoration(
                color: Colors.white,
                // Couleur de fond de la bottom sheet
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                // Coins arrondis en haut
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4), // Couleur de l'ombre
                    spreadRadius: 10, // Propage l'ombre
                    blurRadius: 30, // Flou de l'ombre
                    offset: Offset(0, 3), // Déplacement de l'ombre
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                // Padding à l'intérieur de la "bottom sheet"
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bouton de Test
                    TestButton(),
                    SizedBox(height: 20),
                    // Section des Widgets
                    WidgetsSection(),
                    SizedBox(height: 20),
                    // Section des Offres Personnalisées
                    _buildOfferSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



// Custom offer section
  Widget _buildOfferSection() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFFE6F5FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Découvrez notre offre Hygie+ !',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333)),
          ),
          SizedBox(height: 10),
          Text(
            'Accédez à des fonctionnalités supplémentaires, des programmes de soutien exclusifs, et bien plus encore. Abonnez-vous dès maintenant pour profiter de tous les avantages !',
            style: TextStyle(fontSize: 14, color: Color(0xFF777777)),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text('Je découvre'),
          ),
        ],
      ),
    );
  }
}
