import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/questionnaire/step5.dart';

class Step4 extends StatefulWidget {
  @override
  _Step4State createState() => _Step4State();
}

class _Step4State extends State<Step4> {
  final TextEditingController _controller = TextEditingController();
  bool isButtonEnabled = false;

  void _onTextChanged(String value) {
    setState(() {
      isButtonEnabled = value.isNotEmpty;
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
                child: Icon(Icons.arrow_back, color: Colors.black, size: screenWidth * 0.08),
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
                'Votre dépense moyenne en cigarette par mois',
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
                'Budget tabac',
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
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  onChanged: _onTextChanged,
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: screenWidth * 0.045,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(screenWidth * 0.04),
                    border: InputBorder.none,
                    hintText: 'Ex : 25',
                    hintStyle: TextStyle(
                      color: Color(0xFF707070),
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: screenWidth * 0.04),
                      child: Text(
                        '€',
                        style: TextStyle(
                          color: Color(0xFF707070),
                          fontSize: screenWidth * 0.045,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.05),

              // Bouton "Suivant"
              GestureDetector(
                onTap: isButtonEnabled
                    ? () {
                        print("Budget tabac : ${_controller.text} €");
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Step5()),
                      );
                      }
                    : null,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  decoration: BoxDecoration(
                    color: isButtonEnabled ? Color(0xFF044BD9) : Color(0xFFBFBFBF),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Center(
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
              ),

              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
