import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hygie_mobile/presentation/home_page.dart';
import 'welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hygie_mobile/presentation/questionnaire/welcome_screen_questionnaire.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLogin = true;
  String _errorMessage = '';
  bool _isNavigating = false;
  bool _isPasswordVisible = false;

  bool get isFormValid {
    return _emailController.text.isNotEmpty &&
        (_isLogin || _passwordController.text.length >= 8);
  }

  Future<void> _authenticate() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      if (_isLogin) {
        // Connexion
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        // Assurez-vous que le widget est toujours monté avant de naviguer
        if (mounted) {
          setState(() => _isNavigating = true);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
        }
      } else {
        // Inscription
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        // Ajout d'un document dans Firestore après inscription
        await _firestore
            .collection('profil')
            .doc(userCredential.user?.uid)
            .set({
          'id': userCredential.user?.uid,
          'name': "",
          'image': "",
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'stripeCustomerId': "",
          'plan': "",
          'passwordHash': "",
          'accounts': [],
          'feedbacks': [],
          'consommation': {},
          'points': 0,
        });

        // Afficher la modale de succès
        if (mounted) {
          setState(() => _isNavigating = true);
          _showSuccessModal();
        }
      }
    } catch (e) {
      if (mounted && !_isNavigating) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    }
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
            height: screenHeight * 0.3,
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
                  'Votre compte ${_emailController.text} a bien été enregistré.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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

              // Titre principal
              Text(
                _isLogin ? 'Je me connecte' : 'Je crée mon compte',
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
                controller: _emailController,
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

              // Espacement plus grand avant le bouton de changement de mode
              SizedBox(height: screenHeight * 0.04),

              // Bouton pour changer de mode (connexion/inscription) avec texte plus petit
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    if (_isLogin) {
                      // Si on est en mode connexion, rediriger vers la page Bienvenue
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Bienvenue()),
                      );
                    } else {
                      // Si on est en mode inscription, revenir au mode connexion
                      setState(() {
                        _isLogin = true;
                        _errorMessage = '';
                      });
                    }
                  },
                  child: Text(
                    _isLogin ? 'Créer un compte' : 'J\'ai déjà un compte',
                    style: TextStyle(
                      color: const Color(0xFF044BD9),
                      fontSize: screenWidth * 0.035, // Taille réduite
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w500, // Poids légèrement réduit
                    ),
                  ),
                ),
              ),

              Spacer(), // Pousse le bouton vers le bas

              // Bouton "Connexion" ou "S'inscrire"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isFormValid ? _authenticate : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isFormValid
                        ? const Color(0xFF044BD9)
                        : const Color(0xFFBFBFBF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  ),
                  child: Text(
                    _isLogin ? 'Se connecter' : 'S\'inscrire',
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
          onChanged: (value) => setState(() {
            _errorMessage = '';
          }),
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
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
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
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: const Color(0xFF707070),
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          onChanged: (value) => setState(() {
            _errorMessage = '';
          }),
        ),
        if (!_isLogin)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Le mot de passe doit contenir au moins 8 caractères.',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 12,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }
}
