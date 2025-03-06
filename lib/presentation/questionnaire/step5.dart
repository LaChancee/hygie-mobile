import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/authentification/signup.dart';
import 'package:hygie_mobile/services/user_profile_service.dart';

class Step5 extends StatefulWidget {
  @override
  _Step5State createState() => _Step5State();
}

class _Step5State extends State<Step5> {
  String? selectedGender;
  final UserProfileService _profileService = UserProfileService();

  void _selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF5F8FC),
      body: SafeArea(
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
                'À propos de moi',
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
                'Comment vous identifiez-vous ?',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: screenWidth * 0.045,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // Sélection de genre
              _buildSelectableButton('Masculin'),
              _buildSelectableButton('Féminin'),
              _buildSelectableButton('Non-binaire'),

              Spacer(), // Pousse le bouton vers le bas

              // Bouton "Suivant"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedGender != null
                      ? () {
                          // Sauvegarder le genre
                          _profileService.setGender(selectedGender!);

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Step6()),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedGender != null
                        ? Color(0xFF044BD9)
                        : Color(0xFFBFBFBF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.02),
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

              SizedBox(height: screenHeight * 0.05), // Ajout d'espace en bas
            ],
          ),
        ),
      ),
    );
  }

  // Bouton sélectionnable
  Widget _buildSelectableButton(String text) {
    final double screenWidth = MediaQuery.of(context).size.width;
    bool isSelected = selectedGender == text;

    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.04),
      child: GestureDetector(
        onTap: () => _selectGender(text),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              vertical: screenWidth * 0.04, horizontal: screenWidth * 0.05),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFFDDD4FF) : Color(0xFFDFE5EE),
            border: Border.all(
              color: isSelected ? Color(0xFF8352FF) : Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? Color(0xFF8352FF) : Color(0xFF222222),
                  fontSize: screenWidth * 0.045,
                  fontFamily: 'DM Sans',
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Color(0xFF8352FF),
                  size: screenWidth * 0.06,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
