import 'package:flutter/material.dart';

class ModaleProgram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.9,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // En-tête avec type et titre
                  Text(
                    'Programme de sevrage tabagique',
                    style: TextStyle(
                      color: Color(0xFF044BD9),
                      fontSize: screenWidth * 0.035,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Arrêt progressif en 30 jours',
                    style: TextStyle(
                      color: Color(0xFF044BD9),
                      fontSize: screenWidth * 0.055,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  // Barre de progression
                  Container(
                    margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    height: screenHeight * 0.015,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFDAE0F6), Color(0xFF044BD9)],
                      ),
                    ),
                  ),

                  // Description du programme
                  Text(
                    'Description du programme',
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: screenWidth * 0.045,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Ce programme de 30 jours vous accompagne dans votre démarche d\'arrêt du tabac. Il combine des techniques de réduction progressive, des exercices de gestion du stress et des conseils pratiques pour maximiser vos chances de réussite.',
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: screenWidth * 0.035,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Étapes du programme
                  Text(
                    'Les étapes du programme',
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Grid des étapes
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: [
                      _buildProgramStep(
                        context,
                        'Préparation',
                        'Jours 1-7',
                        'assets/images/preparation.jpg',
                      ),
                      _buildProgramStep(
                        context,
                        'Réduction',
                        'Jours 8-15',
                        'assets/images/reduction.jpg',
                      ),
                      _buildProgramStep(
                        context,
                        'Arrêt',
                        'Jours 16-22',
                        'assets/images/arret.jpg',
                      ),
                      _buildProgramStep(
                        context,
                        'Maintien',
                        'Jours 23-30',
                        'assets/images/maintien.jpg',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Boutons d'action
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xFF044BD9), width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      ),
                      child: Text(
                        'Retour',
                        style: TextStyle(
                          color: Color(0xFF044BD9),
                          fontSize: screenWidth * 0.04,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implémenter la logique de démarrage du programme
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF044BD9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      ),
                      child: Text(
                        'Commencer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.04,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgramStep(
      BuildContext context, String title, String subtitle, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                color: Color(0xFFDAE0F6),
              ),
              child: Center(
                child: Icon(
                  Icons.calendar_today,
                  color: Color(0xFF044BD9),
                  size: 32,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 14,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Color(0xFF707070),
                    fontSize: 12,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
