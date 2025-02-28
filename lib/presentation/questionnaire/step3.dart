import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/questionnaire/step4.dart';

class Step3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF5F8FC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),

                // Icône retour
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back,
                      color: Colors.black, size: screenWidth * 0.08),
                ),

                SizedBox(height: screenHeight * 0.04),

                // Titre principal
                Text(
                  'Pour commencer',
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: screenWidth * 0.08,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                // Texte descriptif
                Text(
                  'Combien de cigarettes fumez-vous par jour ?',
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: screenWidth * 0.045,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                // Label du champ
                Text(
                  'Consommation par jour',
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: screenWidth * 0.045,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: screenHeight * 0.01),

                // **Champ de saisie réel (TextField)**
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFDFE6EE),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number, // Clavier numérique
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: screenWidth * 0.045,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(screenWidth * 0.04),
                      border: InputBorder.none,
                      hintText: 'Ex : 5',
                      hintStyle: TextStyle(
                        color: Color(0xFF707070),
                        fontSize: screenWidth * 0.04,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

                // Bouton "Suivant"
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Step4()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF044BD9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    ),
                    child: Text(
                      'Suivant',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.045,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05), // Ajout d’espace en bas
              ],
            ),
          ),
        ),
      ),
    );
  }
}
