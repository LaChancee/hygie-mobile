import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/dashboard/addiction_card.dart'; // Importer le fichier addiction_card.dart

class ContentsDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Facteur d'échelle pour les petits écrans
    double scaleFactor = screenWidth < 360 ? 0.6 : 1.0;

    return Container(
      width: screenWidth * 0.95, // Largeur dynamique
      constraints: BoxConstraints(
        maxWidth: 600, // Max sur les grands écrans
      ),
      margin: EdgeInsets.only(bottom: 0), // Pas de marge en bas
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1406214F),
            blurRadius: 24,
            offset: Offset(0, -8),
          )
        ],
      ),
      // Utiliser un SingleChildScrollView pour éviter les problèmes de débordement
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            // Définir une hauteur minimale mais pas maximale
            minHeight: 100,
          ),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Ne pas prendre plus d'espace que nécessaire
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Partie supérieure avec padding
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.03 * scaleFactor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ✅ CARTE PRINCIPALE - Utiliser FittedBox pour s'assurer qu'elle s'adapte
                    SizedBox(
                      width: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: screenWidth * 0.9,
                          child: Cards(),
                        ),
                      ),
                    ),

                    SizedBox(height: 8 * scaleFactor),

                    // ✅ TITRE "Mes Widgets" - Simplifié
                    Text(
                      'Mes widgets',
                      style: TextStyle(
                        color: Color(0xFF044BD9),
                        fontSize: screenWidth * 0.035 * scaleFactor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 8 * scaleFactor),

                    // ✅ BOUTON "Ajouter un Widget" - Simplifié
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.008 * scaleFactor,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F8FC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Color(0xFFDAE0F6)),
                      ),
                      child: Center(
                        child: Text(
                          '+ Ajouter un widget',
                          style: TextStyle(
                            color: Color(0xFF044BD9),
                            fontSize: screenWidth * 0.03 * scaleFactor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ✅ OFFRE HYGIÉ+ - Simplifiée
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF044BD9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                padding: EdgeInsets.all(screenWidth * 0.03 * scaleFactor),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Découvrez Hygie+',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.035 * scaleFactor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4 * scaleFactor),
                    Text(
                      'À partir de 3,99€/mois',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.028 * scaleFactor,
                      ),
                    ),
                    SizedBox(height: 6 * scaleFactor),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Découvrir"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF044BD9),
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12 * scaleFactor,
                          vertical: 4 * scaleFactor,
                        ),
                      ),
                    ),
                    SizedBox(height: 4 * scaleFactor),
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
