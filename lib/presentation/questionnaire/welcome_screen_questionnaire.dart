import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/questionnaire/step1.dart';

class Bienvenue extends StatelessWidget {
  const Bienvenue({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Fond blanc avec coins arrondis
          // Contenu principal
          Positioned(
            left: screenWidth * 0.04,
            top: screenHeight * 0.13,
            child: SizedBox(
              width: screenWidth * 0.92, // Largeur adaptative
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre "Bienvenue !"
                  Text(
                    'Bienvenue !',
                    style: TextStyle(
                      color: const Color(0xFF222222),
                      fontSize: screenWidth * 0.08,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Texte d'introduction
                  Text(
                    'Avant de commencer, nous aimerions que vous répondiez à 5 petites questions afin que nous puissions te proposer une aide adaptée.',
                    style: TextStyle(
                      color: const Color(0xFF222222),
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bouton "Suivant"
          Positioned(
            left: screenWidth * 0.04,
            bottom: screenHeight * 0.06,
            child: SizedBox(
              width: screenWidth * 0.92,
              height: screenHeight * 0.07,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => Step1()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF044BD9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                ),
                child: Text(
                  'Suivant',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.045,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
