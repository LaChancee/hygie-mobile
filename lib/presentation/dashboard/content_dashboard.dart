import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/dashboard/addiction_card.dart'; // Importer le fichier addiction_card.dart

class ContentsDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          width: screenWidth * 0.95, // Largeur dynamique
          constraints: BoxConstraints(
            maxWidth: 600, // Max sur les grands écrans
          ),
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.03,
            horizontal: screenWidth * 0.04,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Color(0x1406214F),
                blurRadius: 24,
                offset: Offset(0, -8),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ CARTE PRINCIPALE
              Cards(), // Utiliser le widget Cards

              const SizedBox(height: 16),

              // ✅ TITRE "Mes Widgets"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mes widgets',
                    style: TextStyle(
                      color: Color(0xFF044BD9),
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.widgets,
                      color: Colors.blue, size: screenWidth * 0.06),
                ],
              ),

              const SizedBox(height: 16),

              // ✅ BOUTON "Ajouter un Widget"
              _buildAddWidgetButton(screenWidth, screenHeight),

              const SizedBox(height: 16),

              // ✅ OFFRE HYGIÉ+
              _buildHygiePlusOffer(screenWidth),
            ],
          ),
        ),
      ],
    );
  }

  // ✅ Bouton "Ajouter un Widget"
  Widget _buildAddWidgetButton(double screenWidth, double screenHeight) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
        decoration: BoxDecoration(
          color: Color(0xFFF5F8FC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xFFDAE0F6)),
        ),
        child: Column(
          children: [
            Icon(Icons.add, size: screenWidth * 0.07, color: Colors.blue),
            Text(
              'Ajouter un widget',
              style: TextStyle(
                color: Color(0xFF044BD9),
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Offre Hygie+
  Widget _buildHygiePlusOffer(double screenWidth) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 2, color: Color(0xFF044BD9)),
      ),
      child: Column(
        children: [
          Text(
            'Découvrez notre offre Hygie+ !',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF044BD9),
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),

          // ✅ Prix
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPriceTag('3,99€ /mois', Color(0xFF044BD9), screenWidth),
              const SizedBox(width: 8),
              _buildPriceTag('32,99€ /an', Color(0xFF84F266), screenWidth),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            'Accédez à des outils supplémentaires, des programmes de sevrage et obtenez des récompenses supplémentaires pour chaque effort !',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF222222),
              fontSize: screenWidth * 0.035,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 8),

          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward, size: screenWidth * 0.04),
            label: Text("Découvrir"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF044BD9),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Widget pour afficher le prix avec une bordure arrondie
  Widget _buildPriceTag(String text, Color borderColor, double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, vertical: screenWidth * 0.01),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFF222222),
          fontSize: screenWidth * 0.035,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}