import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hygie_mobile/presentation/authentification/auth_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser; // Récupérer l'utilisateur connecté

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/user.jpg'), // Image du profil
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Email : ${user?.email ?? "Non renseigné"}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Ajoutez ici d'autres informations comme le nom ou d'autres champs du profil
            const SizedBox(height: 40),
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
