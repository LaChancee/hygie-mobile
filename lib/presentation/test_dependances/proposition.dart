import 'package:flutter/material.dart';

class PropositionPage extends StatelessWidget {
  final String dependanceType; // 'tabac' ou 'alcool'
  final int score; // Score calculé

  const PropositionPage({
    Key? key,
    required this.dependanceType,
    this.score = 75, // Valeur par défaut pour démonstration
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Proposition de programme',
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 16,
            fontFamily: 'DM sans',
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF222222)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Titre
                Text(
                  'Votre niveau de dépendance au ${dependanceType == 'tabac' ? 'tabac' : 'alcool'} :',
                  style: const TextStyle(
                    color: Color(0xFF044BD9),
                    fontSize: 20,
                    fontFamily: 'DM sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 24),

                // Statistiques et informations
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title: 'Votre activité',
                        value: 'High',
                        color: const Color(0xFF80D1FF),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        title: 'Votre niveau',
                        value: '$score%',
                        color: const Color(0xB2A885FF),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Programmes proposés
                const Text(
                  'Programmes proposés',
                  style: TextStyle(
                    color: Color(0xFF044BD9),
                    fontSize: 18,
                    fontFamily: 'DM sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 16),

                // Liste des programmes
                _buildParcoursCard(
                  title: 'Programme relaxation',
                  description:
                      'Exercices pour vous aider à réduire votre stress et éviter le besoin de ${dependanceType == 'tabac' ? 'fumer' : 'boire'}.',
                  duration: '4 semaines',
                ),

                const SizedBox(height: 12),

                _buildParcoursCard(
                  title: 'Programme réduction progressive',
                  description:
                      'Réduisez progressivement votre consommation de ${dependanceType == 'tabac' ? 'tabac' : 'alcool'} à travers des objectifs hebdomadaires.',
                  duration: '8 semaines',
                ),

                const SizedBox(height: 12),

                _buildParcoursCard(
                  title: 'Programme sevrage complet',
                  description:
                      'Programme intensif pour arrêter complètement votre consommation de ${dependanceType == 'tabac' ? 'tabac' : 'alcool'}.',
                  duration: '12 semaines',
                ),

                const SizedBox(height: 24),

                // Bouton pour commencer
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Programme sélectionné avec succès !'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF044BD9),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: const Text(
                      'Commencer mon programme',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'DM sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Bouton retour
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // Retour à la page principale
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    style: OutlinedButton.styleFrom(
                      side:
                          const BorderSide(width: 2, color: Color(0xFF044BD9)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: const Text(
                      'Retourner sur la page d\'accueil',
                      style: TextStyle(
                        color: Color(0xFF044BD9),
                        fontSize: 16,
                        fontFamily: 'DM sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
      {required String title, required String value, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F8FC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDAE0F6)),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF044BD9),
                    fontSize: 12,
                    fontFamily: 'DM sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF044BD9),
                    fontSize: 20,
                    fontFamily: 'DM sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParcoursCard(
      {required String title,
      required String description,
      required String duration}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 16,
                  fontFamily: 'DM sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFDAE0F6),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  duration,
                  style: const TextStyle(
                    color: Color(0xFF044BD9),
                    fontSize: 12,
                    fontFamily: 'DM sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF666666),
              fontSize: 14,
              fontFamily: 'DM sans',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Color(0xFF044BD9),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '4.8',
                    style: TextStyle(
                      color: Color(0xFF044BD9),
                      fontSize: 14,
                      fontFamily: 'DM sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(${120 + (title.length * 4)} avis)',
                    style: const TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 12,
                      fontFamily: 'DM sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFF044BD9),
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
