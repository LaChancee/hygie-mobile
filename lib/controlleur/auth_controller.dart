import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/authentification/welcome_screen.dart';
import '../presentation/home_page.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Inscription avec email, mot de passe et nom
  Future<void> createUserWithEmailAndPassword(String email, String password, String nom, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Ajouter les informations de l'utilisateur dans Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'nom': nom,
          'email': email,
          'createdAt': Timestamp.now(),
        });

        // Redirection vers la page de bienvenue après inscription
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      }
    } catch (e) {
      print("Erreur lors de l'inscription : $e");
      // Gérer l'erreur, afficher un message d'erreur, etc.
    }
  }

  // Connexion avec email et mot de passe
  Future<void> signInWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Redirection directe vers la page d'accueil après connexion
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (e) {
      print("Erreur lors de la connexion : $e");
      // Gérer l'erreur, afficher un message d'erreur, etc.
    }
  }
}
