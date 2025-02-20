import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: ""),
            SizedBox(height: 16), // Espacement entre le header et les objectifs
            MesObjectifs(),
            SizedBox(height: 32), // Espacement avant la liste des objectifs
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('objectif')
                  .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Erreur lors du chargement des objectifs'));
                }

                final userObjectives = snapshot.data?.docs.map((doc) {
                  final objective = doc.data() as Map<String, dynamic>;
                  return {
                    'description': objective['description'],
                    'type': objective['type'],
                  };
                }).toList() ?? [];

                return Column(
                  children: [
                    if (userObjectives.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: userObjectives.length,
                        itemBuilder: (context, index) {
                          final objective = userObjectives[index];
                          return Column(
                            children: [
                              _buildGoalSection(
                                title: objective['description'],
                                subtitle: 'Objectif ${objective['type']}',
                                icon: objective['type'] == 'sante'
                                    ? Icons.local_fire_department
                                    : Icons.savings,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProgressionPage(
                                        type: objective['type'],
                                        title: objective['description'], // Passez le titre ici
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 20), // Espacement entre les rubriques
                            ],
                          );
                        },
                      )
                    else
                      Column(
                        children: [
                          Center(child: Text('Aucun objectif trouvé.')),
                          SizedBox(height: 40), // Espacement entre le message et le bouton
                        ],
                      ),
                    // Affichage du bouton "Me fixer un objectif"
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: AddButton(),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 40), // Espacement en bas de la page
          ],
        ),
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
        constraints: BoxConstraints(
          minHeight: 94, // Hauteur minimale dynamique
        ),
        margin: EdgeInsets.symmetric(horizontal: 20),
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
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                color: Color(0xFFDFE6EE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: Icon(icon, color: Color.fromRGBO(4, 75, 217, 1)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
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
                    style: TextStyle(
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
}

class MesObjectifs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text(
            'Mes objectifs',
            style: TextStyle(
              color: Color(0xFF222222),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
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
        width: double.infinity,
        height: 94,
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: Color(0xFF044BD9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.add, color: Colors.white),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'Me fixer un objectif',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
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
