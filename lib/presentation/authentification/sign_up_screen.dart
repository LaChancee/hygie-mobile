import 'package:flutter/material.dart';
import 'package:hygie_mobile/controlleur/auth_controller.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inscription')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                await _authService.createUserWithEmailAndPassword(
                  emailController.text,
                  passwordController.text,
                  nameController.text,
                  context,  // On passe le contexte pour la redirection
                );
              },
              child: Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}
