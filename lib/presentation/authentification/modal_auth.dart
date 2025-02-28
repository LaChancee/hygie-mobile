import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/questionnaire/welcome_screen_questionnaire.dart';

class ContentsArrival extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        widthFactor:
            0.9, // Ajuster la largeur en fonction de la taille de l'écran
        child: Container(
          padding: const EdgeInsets.only(
            top: 24,
            left: 16,
            right: 16,
            bottom: 40,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenWidth * 0.9,
                child: Text(
                  'Nous nous sommes déjà rencontré ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 16,
                    fontFamily: 'DM sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Bienvenue()),
                        );
                      },
                      child: Container(
                        width: screenWidth * 0.9,
                        height: 53,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        decoration: ShapeDecoration(
                          color: Color(0xFF044BD9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Je suis nouveau ici !',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'DM sans',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: screenWidth * 0.9,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: Color(0xFF8352FF)),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'J’ai déjà un compte',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF8352FF),
                              fontSize: 16,
                              fontFamily: 'DM sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
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
