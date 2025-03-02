import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/questionnaire/step2tobaco.dart'; // Assurez-vous d'importer la page Step2
import 'package:hygie_mobile/services/user_profile_service.dart';

class Step1 extends StatefulWidget {
  @override
  _Step1State createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  List<String> selectedOptions = [];
  final UserProfileService _profileService = UserProfileService();

  void _toggleSelection(String option) {
    setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FC),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.03),

              // Titre
              Text(
                'Pour commencer',
                style: TextStyle(
                  color: const Color(0xFF222222),
                  fontSize: screenWidth * 0.08,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Question
              Text(
                'Contre quelle(s) addiction(s) luttez-vous ?',
                style: TextStyle(
                  color: const Color(0xFF222222),
                  fontSize: screenWidth * 0.045,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Options sélectionnables avec le style spécifique
              _buildOption('Alcool'),
              _buildOption('Tabac'),
              Spacer(), // Pousse le bouton vers le bas

              // Bouton "Suivant"
              _buildNextButton(context),
              SizedBox(height: screenHeight * 0.03), // Espacement en bas
            ],
          ),
        ),
      ),
    );
  }

  // Fonction pour créer les options sélectionnables avec le style de la maquette
  Widget _buildOption(String text) {
    final double screenWidth = MediaQuery.of(context).size.width;
    bool isSelected = selectedOptions.contains(text);

    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.04),
      child: GestureDetector(
        onTap: () => _toggleSelection(text),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
          decoration: BoxDecoration(
            color:
                isSelected ? const Color(0xFFDDD4FF) : const Color(0xFFDFE5EE),
            border: Border.all(
              color: isSelected ? const Color(0xFF8352FF) : Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF8352FF)
                    : const Color(0xFF222222),
                fontSize: screenWidth * 0.045,
                fontFamily: 'DM Sans',
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Fonction pour créer le bouton "Suivant"
  Widget _buildNextButton(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: selectedOptions.isEmpty
            ? null
            : () {
                // Sauvegarder les addictions sélectionnées
                _profileService.setAddictions(selectedOptions);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Step2()), // Naviguer vers Step2
                );
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedOptions.isEmpty
              ? const Color(0xFFBFBFBF)
              : const Color(0xFF044BD9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
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
    );
  }
}
