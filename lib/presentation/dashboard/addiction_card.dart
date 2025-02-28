import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          width: screenWidth * 0.9, // 90% de la largeur de l'écran
          constraints: BoxConstraints(maxWidth: 400), // Max sur grands écrans
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.015,
          ),
          decoration: BoxDecoration(
            color: Color(0xFFF5F8FC),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                      decoration: BoxDecoration(
                        color: Color(0xB2A885FF),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Opacity(
                      opacity: 0.50,
                      child: Container(
                        width: screenWidth * 0.2,
                        height: screenWidth * 0.2,
                        decoration: BoxDecoration(
                          color: Color(0xFF80D1FF),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Testez votre niveau de dépendance',
                      style: TextStyle(
                        color: Color(0xFF6C33FF),
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Fixez-vous des objectifs et obtenez des données plus détaillées.',
                      style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: screenWidth * 0.035,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0x7F044BD9),
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1E072250),
                      blurRadius: 12,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      '375',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.star, size: screenWidth * 0.04, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
