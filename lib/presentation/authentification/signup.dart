import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/dashboard/new_dashboard.dart';
import 'package:hygie_mobile/presentation/home_page.dart';
import 'package:hygie_mobile/services/auth_service.dart';
import 'package:hygie_mobile/services/user_profile_service.dart';

class Step6 extends StatefulWidget {
  @override
  _Step6State createState() => _Step6State();
}

class _Step6State extends State<Step6> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserProfileService _profileService = UserProfileService();
  final AuthService _authService = AuthService();
  bool isPasswordVisible = false;
  String _errorMessage = '';
  bool _isLoading = false;

  bool get isFormValid {
    return emailController.text.isNotEmpty &&
        passwordController.text.length >= 8;
  }

  Future<void> _createAccount() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Enregistrer l'email et le mot de passe dans le profil
      _profileService.setEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      // Créer le compte utilisateur avec les données du profil
      await _authService.createUserWithProfile(_profileService.userProfile);

      // Afficher la modale de succès
      if (mounted) {
        setState(() => _isLoading = false);
        _showSuccessModal();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString();
        });
      }
    }
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
                'Je crée mon compte',
                style: TextStyle(
                  color: const Color(0xFF222222),
                  fontSize: screenWidth * 0.08,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              // Champ Email
              _buildTextField(
                label: 'Email',
                controller: emailController,
                hintText: 'exemple@gmail.com',
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(height: screenHeight * 0.03),

              // Champ Mot de passe
              _buildPasswordField(),

              // Message d'erreur
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),

              Spacer(), // Pousse le bouton vers le bas

              // Bouton "Suivant"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isFormValid && !_isLoading ? _createAccount : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isFormValid && !_isLoading
                        ? const Color(0xFF044BD9)
                        : const Color(0xFFBFBFBF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          height: screenWidth * 0.05,
                          width: screenWidth * 0.05,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
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

              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  // Affiche la modale de succès
  void _showSuccessModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        final double screenHeight = MediaQuery.of(context).size.height;
        final double screenWidth = MediaQuery.of(context).size.width;
        final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        return Padding(
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: Container(
            height: screenHeight * 0.3, // Prend 30% de la hauteur de l'écran
            width: screenWidth,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 60),
                const SizedBox(height: 16),
                const Text(
                  'Compte créé avec succès !',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Votre compte ${emailController.text} a bien été enregistré.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Réinitialiser le profil après la création du compte
                    _profileService.resetProfile();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) =>
                          false, // Supprimer toutes les routes précédentes
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF044BD9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    child: Text(
                      'OK',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget champ de texte générique
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF222222),
            fontSize: screenWidth * 0.045,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: const Color(0xFFDFE6EE),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenWidth * 0.04,
            ),
          ),
          onChanged: (value) => setState(() {}),
        ),
      ],
    );
  }

  // Widget champ mot de passe avec icône de visibilité
  Widget _buildPasswordField() {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mot de passe',
          style: TextStyle(
            color: const Color(0xFF222222),
            fontSize: screenWidth * 0.045,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: passwordController,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            hintText: 'Mot de passe',
            filled: true,
            fillColor: const Color(0xFFDFE6EE),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenWidth * 0.04,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: const Color(0xFF707070),
              ),
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
          ),
          onChanged: (value) => setState(() {}),
        ),
        const SizedBox(height: 5),
        const Text(
          'Le mot de passe doit contenir au moins 8 caractères.',
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 12,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
