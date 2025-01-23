import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/home_page.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenue"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bienvenue dans l'application!"),
            SizedBox(height: 20),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                // Redirection vers la page d'accueil
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
