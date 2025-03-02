import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/header.dart';
import 'package:hygie_mobile/services/app_router.dart';

class ProgressionPage extends StatelessWidget {
  final String type;

  const ProgressionPage({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: ""), // Utilisation du header réutilisable
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      AppRouter().goBack(
                          context); // Utiliser AppRouter pour revenir en arrière
                    },
                  ),
                  Text(
                    '$type - Objectifs',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProgressBar(
                              'Arrêter sa consommation en 2 jours', 0.2),
                          SizedBox(height: 20),
                          _buildProgressBar(
                              'Arrêter sa consommation en 5 jours', 0.5),
                          SizedBox(height: 20),
                          _buildProgressBar(
                              'Arrêter sa consommation en 10 jours', 0.8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(String label, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          color: Colors.blue,
        ),
      ],
    );
  }
}
