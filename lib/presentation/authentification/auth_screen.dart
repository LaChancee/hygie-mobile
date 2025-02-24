import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hygie_mobile/presentation/home_page.dart';
import 'welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Instance de Firestore

  bool _isLogin = true;
  String _errorMessage = '';
  bool _isNavigating = false; // Nouveau booléen pour empêcher l'appel à setState après navigation

  Future<void> _authenticate() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      if (_isLogin) {
        // Connexion
        await _auth.signInWithEmailAndPassword(email: email, password: password);

        // Assurez-vous que le widget est toujours monté avant de naviguer
        if (mounted) {
          setState(() => _isNavigating = true); // Empêche setState après navigation
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
        }
      } else {
        // Inscription
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        // Ajout d'un document dans Firestore après inscription
        await _firestore.collection('profil').doc(userCredential.user?.uid).set({
          'id': userCredential.user?.uid,
          'name': "", // Nom initialement vide, l'utilisateur pourra le modifier
          'image': "", // URL de l'image par défaut ou vide
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'stripeCustomerId': "", // ID Stripe vide au départ
          'plan': "", // Plan initial (à définir plus tard si nécessaire)
          'passwordHash': "", // Hash du mot de passe (optionnel)
          'accounts': [], // Liste vide pour les comptes liés
          'feedbacks': [], // Liste vide pour les feedbacks
          'consommation': {}, // Objet vide pour les consommations
          'points': 0, // Initialisation des points à 0
        });

        // Assurez-vous que le widget est toujours monté avant de naviguer
        if (mounted) {
          setState(() => _isNavigating = true);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WelcomeScreen()));
        }
      }
    } catch (e) {
      if (mounted && !_isNavigating) { // Vérifiez que le widget est monté et pas en navigation
        setState(() {
          _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Connexion' : 'Inscription'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text(_isLogin ? 'Se connecter' : 'S\'inscrire'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(_isLogin ? 'Créer un compte' : 'J\'ai déjà un compte'),
            ),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
