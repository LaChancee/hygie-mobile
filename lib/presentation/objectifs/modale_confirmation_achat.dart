import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ModaleConfirmationAchat extends StatefulWidget {
  final String titre;
  final int points;
  final bool isCompleted;
  final String objectifId; // Ajoutez l'ID de l'objectif

  const ModaleConfirmationAchat({
    required this.titre,
    required this.points,
    required this.isCompleted,
    required this.objectifId, // Ajoutez l'ID de l'objectif
  });

  @override
  _ModaleConfirmationAchatState createState() => _ModaleConfirmationAchatState();
}

class _ModaleConfirmationAchatState extends State<ModaleConfirmationAchat> {
  bool _isValidated = false;
  int _currentPoints = 0;

  @override
  void initState() {
    super.initState();
    _fetchCurrentPoints();
  }

  Future<void> _fetchCurrentPoints() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final profilRef = FirebaseFirestore.instance.collection('profil').doc(userId);
      final snapshot = await profilRef.get();
      if (snapshot.exists) {
        setState(() {
          _currentPoints = snapshot.data()?['points'] ?? 0;
        });
      }
    }
  }

  Future<void> _incrementPoints() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final profilRef = FirebaseFirestore.instance.collection('profil').doc(userId);
      final objectifRef = FirebaseFirestore.instance.collection('objectif').doc(widget.objectifId);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final profilSnapshot = await transaction.get(profilRef);
        final objectifSnapshot = await transaction.get(objectifRef);

        if (!profilSnapshot.exists) {
          throw Exception("Profil does not exist!");
        }
        if (!objectifSnapshot.exists) {
          throw Exception("Objectif does not exist!");
        }

        final currentPoints = profilSnapshot.data()?['points'] ?? 0;

        transaction.update(profilRef, {'points': currentPoints + widget.points});
        setState(() {
          _currentPoints = currentPoints + widget.points;
          _isValidated = true; // Mettre à jour l'état pour indiquer que la validation est effectuée
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.0, // Prendre toute la largeur de l'écran
      child: Container(
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
        child: SingleChildScrollView(
          child: Column(
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
                        style: TextStyle(
                          color: Color(0xFF222222),
                          fontSize: 20,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'La libération d\'adrénaline causée par le tabac augmente la pression artérielle. Le risque d\'infarctus et de maladies cardiaques augmente. Après 12 heures, la tension artérielle revient doucement à la normale, allégeant le poids sur votre cœur.',
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
                        Text(
                          widget.isCompleted
                              ? (_isValidated
                                  ? 'Palier déjà validé, récompense déjà versée.'
                                  : 'Votre cagnotte après validation sera de : ')
                              : 'Cet objectif n\'a pas encore été atteint.',
                          style: TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 14,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        if (widget.isCompleted && !_isValidated)
                          Text(
                            '${_currentPoints + widget.points}',
                            style: TextStyle(
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
                          color: Color(0xFF8352FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Fermer',
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
                  if (widget.isCompleted && !_isValidated) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          try {
                            await _incrementPoints();
                          } catch (e) {
                            // Gérer l'erreur si les points ont déjà été validés
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                        child: Container(
                          height: 53,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          decoration: ShapeDecoration(
                            color: Color(0xFF044BD9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Valider',
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}