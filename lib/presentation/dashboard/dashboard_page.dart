import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hygie_mobile/commons/colors.dart';
import 'package:hygie_mobile/commons/header.dart';
import 'package:hygie_mobile/presentation/dashboard/header_dashboard.dart'; // Assurez-vous que le chemin est correct

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
                    _buildTestButton(),
                    SizedBox(height: 20),
                    // Section des Widgets
                    _buildWidgets(),
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

  Widget _buildBilanButton(String label) {
    return ElevatedButton(
      onPressed: () {
        // Ajoute ici l'action du bouton
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.2),
        // Couleur de fond avec 80% de transparence
        foregroundColor: Colors.white,
        // Couleur du texte du bouton
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        // Taille des boutons
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Coins arrondis
          side:
              BorderSide(color: Colors.white, width: 2), // Bordure blanche 100%
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 16), // Style du texte
      ),
    );
  }

// Consumption Test Button
  Widget _buildTestButton() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            // Couleur de l'ombre avec transparence
            spreadRadius: 2,
            // Propage l'ombre (comme une bordure floue)
            blurRadius: 20,
            // Floutage de l'ombre
            offset:
                Offset(0, 3), // Déplacement de l'ombre (horizontal, vertical)
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Utilise Flexible pour éviter que le texte dépasse
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Aligne le texte à gauche
              children: [
                Text(
                  'Testez votre niveau de dépendance',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF8C5EFF),
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1, // Limite le texte à une seule ligne
                  overflow: TextOverflow
                      .ellipsis, // Ajoute "..." si le texte est trop long
                ),
                SizedBox(height: 5),
                // Ajoute un petit espace entre les deux textes
                Text(
                  'Fixez-vous des objectifs et obtenez des données plus détaillées.',
                  style: TextStyle(fontSize: 14, color: AppColors.textColor),
                  maxLines: 2,
                  // Limite à deux lignes pour la description
                  overflow: TextOverflow.ellipsis,
                  // Ajoute "..." si le texte dépasse
                  softWrap:
                      true, // Permet au texte de passer à la ligne suivante
                ),
              ],
            ),
          ),

          // Le conteneur pour l'affichage "+20"
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              '+20',
              style: TextStyle(
                  color: Color(0xFF8C5EFF), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

// Widgets section (Argent dépensé, Jours sans alcool, etc.)
  Widget _buildWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Aligne le texte à gauche
      children: [
        // Texte "Mes Widgets" aligné à gauche avec espacement en bas
        Padding(
          padding: const EdgeInsets.only(left: 5.0, bottom: 15),
          // Padding pour le texte
          child: Text(
            "Mes Widgets",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        // Espacement entre les widgets
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildWidgetCard('Argent dépensé', '138,67 €', 'vs 26 €'),
            // Ajout d'un espace entre les deux boutons
            SizedBox(width: 20), // Ajout d'espace entre les widgets
            _buildWidgetCard('Jours sans alcool', '23 jours', 'Depuis le 5 juin 2024'),
          ],
        ),
        SizedBox(height: 20),
        // Ajoute un espacement entre les widgets et le graphique
        _buildConsumptionGraph(),
        SizedBox(height: 20),
        _buildPlaceholderWidget(),
      ],
    );
  }

// Widget card for displaying metrics
  Widget _buildWidgetCard(String title, String mainValue, String subValue) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(0xFFF1F8FF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, color: Color(0xFF333333)),
            ),
            SizedBox(height: 10),
            Text(
              mainValue,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00AEEF)),
            ),
            SizedBox(height: 5),
            Text(
              subValue,
              style: TextStyle(fontSize: 14, color: Color(0xFF777777)),
            ),
          ],
        ),
      ),
    );
  }

// Consumption graph widget placeholder
// Consumption graph widget placeholder
  Widget _buildConsumptionGraph() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFFF1F8FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Consommation de la semaine',
            style: TextStyle(fontSize: 16, color: Color(0xFF333333)),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              return Expanded(
                // Utilisation d'Expanded pour s'assurer que chaque case ne déborde pas
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  // Ajout d'une petite marge horizontale
                  decoration: BoxDecoration(
                    color: index == 0 ? Color(0xFF00AEEF) : Color(0xFFDDDDDD),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Jour ${index + 1}',
                    textAlign: TextAlign.center, // Centrer le texte
                    style: TextStyle(
                        color:
                            Color(0xFFFFFFFF)), // Corriger la couleur du texte
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

// Placeholder for additional widgets
  Widget _buildPlaceholderWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFF00AEEF)),
      ),
      child: Center(
        child: Text(
          'Widget personnalisé',
          style: TextStyle(fontSize: 16, color: Color(0xFF00AEEF)),
        ),
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
