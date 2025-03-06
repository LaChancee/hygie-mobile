import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/questionnaire/welcome_screen_questionnaire.dart';
import 'package:hygie_mobile/presentation/authentification/auth_screen.dart';

class ContentsArrival extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double safeAreaTop = MediaQuery.of(context).padding.top;
    final double safeAreaBottom = MediaQuery.of(context).padding.bottom;

    return Container(
      height: screenHeight,
      width: screenWidth,
      child: Stack(
        children: [
          // Partie transparente supérieure (pour permettre de voir le splash screen)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.6, // 60% supérieur transparent
            child: GestureDetector(
              // Désactiver les interactions sur cette zone
              onTap: () {},
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),

          // Contenu de la modale (partie inférieure)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                24,
                24,
                24,
                24 + safeAreaBottom,
              ),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x1406214F),
                    blurRadius: 24,
                    offset: Offset(0, -8),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Calculer la hauteur disponible
                  final availableHeight = constraints.maxHeight;

                  return SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: screenHeight * 0.4, // Hauteur minimale
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Indicateur de modal
                            Container(
                              width: 40,
                              height: 4,
                              margin: EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),

                            // Titre
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                'Nous nous sommes déjà rencontré ?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: screenWidth * 0.045,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            // Espace flexible
                            SizedBox(height: 24),

                            // Boutons
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Bouton "Je suis nouveau ici"
                                  _buildButton(
                                    context: context,
                                    text: 'Je suis nouveau ici !',
                                    isPrimary: true,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Bienvenue()),
                                      );
                                    },
                                  ),

                                  SizedBox(height: 16),

                                  // Bouton "J'ai déjà un compte"
                                  _buildButton(
                                    context: context,
                                    text: "J'ai déjà un compte",
                                    isPrimary: false,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AuthScreen()),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String text,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56, // Hauteur fixe pour tous les appareils
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: ShapeDecoration(
          color: isPrimary ? Color(0xFF044BD9) : Colors.transparent,
          shape: RoundedRectangleBorder(
            side: isPrimary
                ? BorderSide.none
                : BorderSide(width: 2, color: Color(0xFF8352FF)),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isPrimary ? Colors.white : Color(0xFF8352FF),
              fontSize: 16,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
