import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/questionnaire/step4.dart';
import 'package:hygie_mobile/services/user_profile_service.dart';

class Step3 extends StatefulWidget {
  @override
  _Step3State createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  final TextEditingController _cigarettesController = TextEditingController();
  final UserProfileService _profileService = UserProfileService();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _cigarettesController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = _cigarettesController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _cigarettesController.removeListener(_updateButtonState);
    _cigarettesController.dispose();
    super.dispose();
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
                  controller: _cigarettesController,
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

              Spacer(), // Pousse le bouton vers le bas

              // Bouton "Suivant"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () {
                          // Sauvegarder le nombre de cigarettes par jour
                          int cigarettesPerDay =
                              int.tryParse(_cigarettesController.text) ?? 0;
                          _profileService.setCigarettesPerDay(cigarettesPerDay);

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Step4()),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isButtonEnabled ? Color(0xFF044BD9) : Color(0xFFBFBFBF),
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
}
