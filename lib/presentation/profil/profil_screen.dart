import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hygie_mobile/presentation/authentification/auth_screen.dart';
import 'package:hygie_mobile/presentation/profil/widgets/profile_header.dart';
import 'package:hygie_mobile/presentation/profil/widgets/profile_badges.dart';
// import 'package:hygie_mobile/presentation/profil/widgets/profile_dependency.dart';
// import 'package:hygie_mobile/presentation/profil/widgets/profile_parrainage.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser; // Récupérer l'utilisateur connecté

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mon Profil',
          style: TextStyle(
            color: Color(0xFF222222),
            fontFamily: 'DM Sans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.blue),
            onPressed: () {
              // Action à effectuer lorsque l'icône de paramètres est cliquée
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(user: user),
            const SizedBox(height: 20),
            ProfileBadges(),
            const SizedBox(height: 20),
            // ContentParrainage(), // Ajouter le widget ContentParrainage ici
            // const SizedBox(height: 20),
            // ContentDependance(),
            // const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Déconnexion de l'utilisateur
                  FirebaseAuth.instance.signOut();
                  // Rediriger vers l'écran d'authentification
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                    (route) => false,
                  );
                },
                child: const Text('Se déconnecter'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}