import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConsommationFormScreen extends StatefulWidget {
  @override
  _ConsommationFormScreenState createState() => _ConsommationFormScreenState();
}

class _ConsommationFormScreenState extends State<ConsommationFormScreen> {
  final _typeController = TextEditingController();
  final _quantiteController = TextEditingController();
  String _errorMessage = '';

  Future<void> _addConsommation() async {
    final type = _typeController.text.trim();
    final quantite = int.tryParse(_quantiteController.text.trim());
    if (type.isEmpty || quantite == null) {
      setState(() {
        _errorMessage = "Veuillez entrer un type et une quantité valide.";
      });
      return;
    }

    try {
      final now = DateTime.now();
      final consommation = {
        'type': type,
        'quantité': quantite,
        'dateConsommation': now.toIso8601String(),
        'createdAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
      };

      await FirebaseFirestore.instance.collection('consommations').add(consommation);
      Navigator.of(context).pop(); // Retour à l'écran précédent après ajout
    } catch (e) {
      setState(() {
        _errorMessage = "Erreur lors de l'ajout : ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une consommation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _typeController,
              decoration: InputDecoration(labelText: 'Type'),
            ),
            TextField(
              controller: _quantiteController,
              decoration: InputDecoration(labelText: 'Quantité'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addConsommation,
              child: const Text('Enregistrer'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _typeController.dispose();
    _quantiteController.dispose();
    super.dispose();
  }
}
