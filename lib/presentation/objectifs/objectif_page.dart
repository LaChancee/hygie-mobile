import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hygie_mobile/presentation/dashboard/top_bar.dart';
import 'progression_page.dart';
import 'choisir_objectif_page.dart';

class ObjectifsPage extends StatefulWidget {
  @override
  _ObjectifsPageState createState() => _ObjectifsPageState();
}

class _ObjectifsPageState extends State<ObjectifsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: TopBar(
              showCagnotte: false,
            ),
          ),
          const SizedBox(height: 16), // Espacement entre le header et les objectifs
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('objectif')
                  .where('userId',
                      isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(
                      child: Text('Erreur lors du chargement des objectifs'));
                }

                final userObjectives = snapshot.data?.docs.map((doc) {
                      final objective = doc.data() as Map<String, dynamic>;
                      return {
                        'id': doc.id, // Ajoutez l'ID du document ici
                        'description': objective['description'],
                        'type': objective['type'],
                      };
                    }).toList() ?? [];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16), // Espacement entre le header et les objectifs
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const MesObjectifs(), // Ajouter le widget MesObjectifs ici
                    ),
                    const SizedBox(height: 16), // Espacement entre le titre et les objectifs
                    if (userObjectives.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: userObjectives.length,
                          itemBuilder: (context, index) {
                            final objective = userObjectives[index];
                            return Column(
                              children: [
                                _buildGoalSection(
                                  title: objective['description'],
                                  subtitle: 'Objectif ${objective['type']}',
                                  icon: _getIconForGoalType(objective['type']),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProgressionPage(
                                          type: objective['type'],
                                          title: objective['description'],
                                          objectifId: objective['id'], // Passez l'ID ici
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                    height: 20), // Espacement entre les rubriques
                              ],
                            );
                          },
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: const [
                            SizedBox(
                              width: 358,
                              child: Text(
                                'Fixez-vous de nouveaux objectifs, accomplissez-les et obtenez plus de récompenses !',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 14,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 40), // Espacement entre le message et le bouton
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: AddButton(),
      ),
    );
  }

  Widget _buildGoalSection({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(
          minHeight: 94, // Hauteur minimale dynamique
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x19072250),
              blurRadius: 12,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                color: const Color(0xFFDFE6EE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: Icon(icon, color: const Color.fromRGBO(4, 75, 217, 1)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF707070),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
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
  IconData _getIconForGoalType(String type) {
    switch (type) {
      case 'santé':
        return Icons.health_and_safety;
      case 'épargne':
        return Icons.savings;
      case 'Alcool':
        return Icons.local_bar;
      case 'Tabac':
        return Icons.smoking_rooms;
      default:
        return Icons.help_outline;
    }
  }
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChoisirObjectifPage(
                    category: 'Choisir un objectif',
                  )),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 32, // Prendre toute la largeur de l'écran avec une marge de 16 de chaque côté
        height: 72,
        padding: const EdgeInsets.all(16),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFF044BD9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x19072250),
              blurRadius: 12,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0xFFDAE0F6),
                shape: RoundedRectangleBorder(
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
                    decoration: const BoxDecoration(),
                    child: const Icon(Icons.add, color: Color(0xFF044BD9)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Text(
                'Me fixer un objectif',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MesObjectifs extends StatelessWidget {
  const MesObjectifs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(
          width: 358,
          child: Text(
            'Mes objectifs',
            style: TextStyle(
              color: Color(0xFF222222),
              fontSize: 20,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
