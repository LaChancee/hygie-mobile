import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/recompense/recapitulatif_achat.dart'; // Importer la page de destination
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hygie_mobile/presentation/home_page.dart';

class ModaleConfirmationRecompense extends StatefulWidget {
  final String titre;
  final int points;
  final bool isCompleted;

  const ModaleConfirmationRecompense({
    Key? key,
    required this.titre,
    required this.points,
    required this.isCompleted,
  }) : super(key: key);

  @override
  _ModaleConfirmationRecompenseState createState() => _ModaleConfirmationRecompenseState();
}

class _ModaleConfirmationRecompenseState extends State<ModaleConfirmationRecompense> {
  bool _isConfirmed = false;
  int _remainingPoints = 0;

  @override
  void initState() {
    super.initState();
    _loadUserPoints();
  }

  Future<void> _loadUserPoints() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('profil')
            .doc(user.uid)
            .get();
        
        if (userDoc.exists) {
          final currentPoints = userDoc.data()?['points'] as int? ?? 0;
          setState(() {
            _remainingPoints = currentPoints - widget.points;
          });
        }
      } catch (e) {
        print('Erreur lors de la récupération des points: $e');
      }
    }
  }

  Future<void> _updateUserPoints() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('profil')
            .doc(user.uid)
            .update({
          'points': _remainingPoints,
        });
        
        // Notifier l'en-tête du changement des points
        // Cette partie dépend de votre structure d'application
        // Si vous utilisez un stream pour les points dans l'en-tête, la mise à jour se fera automatiquement
        // Sinon, vous devrez utiliser une notification ou un callback
        
      } catch (e) {
        print('Erreur lors de la mise à jour des points: $e');
      }
    }
  }

  void _confirm() async {
    await _updateUserPoints();
    setState(() {
      _isConfirmed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.0, // Prendre toute la largeur de l'écran
      child: Container(
        padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: _isConfirmed
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 2, color: Color(0xFF84F266)),
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
                            child: const Icon(Icons.check, color: Color(0xFF84F266)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Transaction effectuée avec succès !',
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
                              // Fermer la modale et retourner à la page d'accueil
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) => HomePage()),
                                (route) => false,
                              );
                            },
                            child: Container(
                              height: 53,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              decoration: ShapeDecoration(
                                color: const Color(0xFF044BD9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Continuer',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              widget.titre,
                              style: const TextStyle(
                                color: Color(0xFF222222),
                                fontSize: 20,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Confirmer l\'obtention de cette récompense ?',
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 14,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Votre cagnotte après achat sera de : ',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 14,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '$_remainingPoints',
                                style: const TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 16,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Fermer la modale
                            },
                            child: Container(
                              height: 53,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              decoration: ShapeDecoration(
                                color: const Color(0xFF8352FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Annuler',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: _confirm,
                            child: Container(
                              height: 53,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              decoration: ShapeDecoration(
                                color: const Color(0xFF044BD9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Confirmer',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}