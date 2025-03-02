import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hygie_mobile/commons/header.dart';
import 'package:hygie_mobile/presentation/objectifs/progression_page.dart';
import 'package:hygie_mobile/services/app_router.dart';

class ChoisirObjectifPage extends StatelessWidget {
  final String category;

  const ChoisirObjectifPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: ""),
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
                    '$category - Objectifs',
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
              child: Column(
                children: [
                  _buildGoalOption(
                    context,
                    'Aucune consommation pendant 10 jours',
                    '8 juin 2024, 21:48',
                    Color(0xFFDDD4FF),
                    'santé',
                    '+ 30', // Points en dur
                  ),
                  SizedBox(height: 16),
                  _buildGoalOption(
                    context,
                    'Je me laisse un mois pour arrêter de consommer',
                    'Objectif santé',
                    Color(0xFFDFE6EE),
                    'santé',
                    '+ 90', // Points en dur
                  ),
                  SizedBox(height: 16),
                  _buildGoalOption(
                    context,
                    'Je me laisse une semaine pour arrêter de consommer',
                    'Objectif santé',
                    Color(0xFFDFE6EE),
                    'santé',
                    '+ 21', // Points en dur
                  ),
                  SizedBox(height: 16),
                  _buildGoalOption(
                    context,
                    "Je veux arrêter de consommer dès aujourd'hui",
                    'Objectif santé',
                    Color(0xFFDFE6EE),
                    'santé',
                    '+ 1', // Points en dur
                  ),
                  SizedBox(height: 16),
                  _buildGoalOption(
                    context,
                    'Je veux réaliser des économies',
                    'Objectif épargne',
                    Color(0xFFDDD4FF),
                    'épargne',
                    '+ 50', // Points en dur
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget pour afficher chaque objectif dans la liste
  Widget _buildGoalOption(BuildContext context, String title, String subtitle,
      Color backgroundColor, String type,
      [String? points]) {
    return GestureDetector(
      onTap: () {
        _showModalBottomSheet(context, title);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x19072250),
              blurRadius: 12,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: _getIconForGoalType(
                  type), // Utilisation de l'icône appropriée
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Color(0xFF707070),
                      fontSize: 12,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      height: 1.31,
                    ),
                  ),
                ],
              ),
            ),
            if (points != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: ShapeDecoration(
                  color: Color(0xFFDAE0F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      points,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF044BD9),
                        fontSize: 12,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Retourne l'icône appropriée pour le type d'objectif
  Widget _getIconForGoalType(String type) {
    switch (type) {
      case 'santé':
        return const Icon(Icons.health_and_safety,
            color: Color.fromRGBO(4, 75, 217, 1));
      case 'épargne':
        return const Icon(Icons.savings, color: Color.fromRGBO(4, 75, 217, 1));
      case 'alcool':
        return const Icon(Icons.local_bar,
            color: Color.fromRGBO(4, 75, 217, 1));
      case 'tabac':
        return const Icon(Icons.smoking_rooms,
            color: Color.fromRGBO(4, 75, 217, 1));
      default:
        return const Icon(Icons.help_outline, color: Colors.grey);
    }
  }

  void _showModalBottomSheet(BuildContext context, String selectedGoal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        return ModaleConfirmationAchat(selectedGoal: selectedGoal);
      },
    );
  }
}

class ModaleConfirmationAchat extends StatefulWidget {
  final String selectedGoal;

  ModaleConfirmationAchat({required this.selectedGoal});

  @override
  _ModaleConfirmationAchatState createState() =>
      _ModaleConfirmationAchatState();
}

class _ModaleConfirmationAchatState extends State<ModaleConfirmationAchat> {
  String? _selectedOption;
  bool _isSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!_isSuccess)
            Column(
              children: [
                Text(
                  'Fixer cet objectif pour :',
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 20,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOption = 'Tabac';
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    padding: const EdgeInsets.all(16),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: _selectedOption == 'Tabac'
                          ? Color(0xFFDDD4FF)
                          : Color(0xFFF5F8FC),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1,
                            color: _selectedOption == 'Tabac'
                                ? Color(0xFF8352FF)
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tabac',
                          style: TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 14,
                            fontFamily: 'DM Sans',
                            fontWeight: _selectedOption == 'Tabac'
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOption = 'Alcool';
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    padding: const EdgeInsets.all(16),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: _selectedOption == 'Alcool'
                          ? Color(0xFFDDD4FF)
                          : Color(0xFFF5F8FC),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1,
                            color: _selectedOption == 'Alcool'
                                ? Color(0xFF8352FF)
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Alcool',
                          style: TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 14,
                            fontFamily: 'DM Sans',
                            fontWeight: _selectedOption == 'Alcool'
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    if (_selectedOption != null) {
                      _saveGoalToFirebase();
                      setState(() {
                        _isSuccess = true;
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: ShapeDecoration(
                      color: Color(0xFF044BD9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Continuer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2, color: Color(0xFF84F266)),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: Icon(Icons.check, color: Color(0xFF84F266)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Objectif ajouté avec succès !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 20,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: ShapeDecoration(
                      color: Color(0xFF044BD9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Continuer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Future<void> _saveGoalToFirebase() async {
    final firestore = FirebaseFirestore.instance;
    final userId = FirebaseAuth
        .instance.currentUser?.uid; // Récupérer l'ID de l'utilisateur actuel
    if (userId != null) {
      final goalData = {
        'userId': userId,
        'type': _selectedOption,
        'description': widget.selectedGoal,
        'dateDebut': DateTime.now().toIso8601String(),
        'dateFin': DateTime.now().add(Duration(days: 10)).toIso8601String(),
        'statut': 'en cours',
        'progress': 0,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };

      await firestore.collection('objectif').add(goalData);
    } else {
      // Gérer le cas où l'utilisateur n'est pas connecté
      print('Aucun utilisateur connecté');
    }
  }
}
