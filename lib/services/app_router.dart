import 'package:flutter/material.dart';

// Classe pour gérer la navigation
class AppRouter {
  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() {
    return _instance;
  }

  AppRouter._internal();

  // Méthode pour naviguer vers une nouvelle page
  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
        fullscreenDialog: false,
      ),
    );
  }

  // Méthode pour revenir à la page précédente
  void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
