import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hygie_mobile/commons/colors.dart';  // Utilise uniquement widgets.dart

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            _buildHeader(),
            SizedBox(height: 20),
            // Consumption Test
            _buildTestButton(),
            SizedBox(height: 20),
            // Widgets section
            _buildWidgets(),
            SizedBox(height: 20),
            // Custom Offer Section
            _buildOfferSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Color(0xFFB3E5FC), // Exemple d'une couleur de fond (bleu clair)
      padding: const EdgeInsets.all(20), // Tu peux aussi ajouter du padding si nécessaire
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Non-fumeur depuis :',
            style: TextStyle(fontSize: 18, color: Color(0xFF333333)),
          ),
          SizedBox(height: 5),
          Text(
            '2 jours',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF00AEEF)),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: _buildActionButton('+ Consommation'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: _buildBilanButton('Bilan'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Button Builder for Consommation and Bilan
  Widget _buildActionButton(String label) {
    return ElevatedButton(
      onPressed: () {
        // Ajoute ici l'action du bouton
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor, // Couleur de fond du bouton
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Taille des boutons
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Coins arrondis
        ),
      ),
      child: Text(label, style: TextStyle(fontSize: 16)),
    );
  }
  Widget _buildBilanButton(String label){
    return ElevatedButton(
      onPressed: () {
        // Ajoute ici l'action du bouton
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0x08FFFFFF), // Couleur de fond du bouton
        foregroundColor: Colors.white,
        textStyle: TextStyle(color: Colors.white),    // Couleur du texte du bouton
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Taille des boutons
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Coins arrondis
        ),
      ),
      child: Text(label, style: TextStyle(fontSize: 16), selectionColor: Colors.white,),
    );
  }


  // Consumption Test Button
  Widget _buildTestButton() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFFF1F8FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Testez votre niveau de dépendance',
            style: TextStyle(fontSize: 16, color: AppColors.textColor),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              '+20',
              style: TextStyle(color: Color(0xFFFFFF), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Widgets section (Argent dépensé, Jours sans alcool, etc.)
  Widget _buildWidgets() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildWidgetCard('Argent dépensé', '138,67 €', 'vs 26 €'),
            _buildWidgetCard('Jours sans alcool', '23 jours', 'Depuis le 5 juin 2024'),
          ],
        ),
        SizedBox(height: 20),
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF00AEEF)),
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
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: index == 0 ? Color(0xFF00AEEF) : Color(0xFFDDDDDD),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Jour ${index + 1}',
                  style: TextStyle(color: Color(0xFFFFFF)),
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
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
