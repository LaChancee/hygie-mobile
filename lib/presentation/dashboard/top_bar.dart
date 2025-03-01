import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent, // Couleur de fond transparente
        boxShadow: [], // Retirer l'ombre
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo + Notification
          Row(
            children: [
              // Icône de cloche outlined en couleur primaire
              Icon(Icons.notifications_outlined, color: Theme.of(context).primaryColor, size: 40),
              SizedBox(width: 16),
              // Widget CagnotteMini
              CagnotteMini(),
            ],
          ),

          // Profil (Avatar)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class CagnotteMini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 66,
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(124),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x1E06214F),
                blurRadius: 12,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '0',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF044BD9),
                  fontSize: 14,
                  fontFamily: 'DM sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 4), // Ajout d'espace entre le chiffre et l'icône
              Container(
                width: 16,
                height: 16,
                child: Image.asset('assets/images/blue_hycoins.png'), // Remplacez par le chemin de votre image
              ),
            ],
          ),
        ),
      ],
    );
  }
}
