import 'package:flutter/material.dart';

class CardsContext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: screenWidth > 600 ? 400 : double.infinity, // Largeur adaptative
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Non-fumeur depuis :',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '0 jours',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 48,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Bouton "Bilan"
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.bar_chart, color: Color(0xFF044BD9)),
                    label: Text(
                      'Bilan',
                      style: TextStyle(color: Color(0xFF044BD9), fontSize: 16),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFF044BD9), width: 2),
                      shape: StadiumBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Bouton "Consommation"
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.smoking_rooms, color: Colors.white),
                    label: Text(
                      'Consommation',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF044BD9),
                      shape: StadiumBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
