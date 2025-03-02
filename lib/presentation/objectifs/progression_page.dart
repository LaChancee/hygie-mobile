import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hygie_mobile/commons/header.dart';
import 'package:hygie_mobile/presentation/objectifs/modale_confirmation_achat.dart';

class ProgressionPage extends StatefulWidget {
  final String type;
  final String title;
  final String objectifId;

  const ProgressionPage(
      {required this.type, required this.title, required this.objectifId});

  @override
  _ProgressionPageState createState() => _ProgressionPageState();
}

class _ProgressionPageState extends State<ProgressionPage> {
  DateTime? startDate;
  bool isLoading = true;

  // Liste statique de sous-objectifs
  final List<Map<String, dynamic>> sousObjectifs = [
    {
      'titre': 'La pression sanguine redevient normale.',
      'description': 'Palier atteint en 20 minutes.',
      'points': 5,
      'duration': Duration(minutes: 20),
      'progression': 0.0,
    },
    {
      'titre': 'Les cellules du corps sont normalement oxygénées.',
      'description': 'Palier atteint en 8 heures.',
      'points': 10,
      'duration': Duration(hours: 8),
      'progression': 0.0,
    },
    {
      'titre': 'Le risque de crise cardiaque diminue déjà !',
      'description': 'Palier atteint en 24 heures.',
      'points': 20,
      'duration': Duration(hours: 24),
      'progression': 0.0,
    },
    {
      'titre': 'Le goût et l\'odorat s\'améliorent.',
      'description': 'Palier atteint en 48 heures.',
      'points': 30,
      'duration': Duration(days: 2),
      'progression': 0.0,
    },
    {
      'titre': 'Respirer devient plus facile.',
      'description': 'Palier atteint en 72 heures.',
      'points': 40,
      'duration': Duration(days: 3),
      'progression': 0.0,
    },
    {
      'titre': 'La toux et la fatigue diminuent.',
      'description': 'Palier atteint entre 2 et 10 semaines.',
      'points': 50,
      'duration': Duration(days: 70),
      'progression': 0.0,
    },
    {
      'titre': 'Les bronches retrouvent toutes leurs fonctions.',
      'description': 'Palier atteint entre 1 et 9 mois.',
      'points': 60,
      'duration': Duration(days: 270),
      'progression': 0.0,
    },
    {
      'titre': 'Le risque de crise cardiaque a diminué de moitié.',
      'description': 'Palier atteint en 1 an.',
      'points': 70,
      'duration': Duration(days: 365),
      'progression': 0.0,
    },
    {
      'titre': 'Le risque de cancer du poumon a diminué presque de moitié.',
      'description': 'Palier atteint en 5 ans.',
      'points': 80,
      'duration': Duration(days: 1825),
      'progression': 0.0,
    },
    {
      'titre':
          'L\'espérance de vie est redevenue identique à celle d\'une personne qui n\'a jamais fumé.',
      'description': 'Palier atteint entre 10 et 15 ans.',
      'points': 100,
      'duration': Duration(days: 5475),
      'progression': 0.0,
    },
  ];

  @override
  void initState() {
    super.initState();
    _fetchStartDate();
  }

  Future<void> _fetchStartDate() async {
    final doc = await FirebaseFirestore.instance
        .collection('objectif')
        .doc(widget.objectifId)
        .get();
    if (doc.exists) {
      setState(() {
        startDate = DateTime.parse(doc['createdAt']);
        _calculateProgression();
        isLoading = false;
      });
    }
  }

  void _calculateProgression() {
    if (startDate == null) return;

    final now = DateTime.now();

    for (var sousObjectif in sousObjectifs) {
      final duration = sousObjectif['duration'] as Duration;
      final endDate = startDate!.add(duration);

      if (now.isAfter(endDate)) {
        sousObjectif['progression'] = 1.0;
      } else {
        final totalDuration = endDate.difference(startDate!).inSeconds;
        final elapsedDuration = now.difference(startDate!).inSeconds;
        sousObjectif['progression'] = elapsedDuration / totalDuration;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(title: ""),
                  SizedBox(height: 20),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(
                                  context); // Retour à la page précédente
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 20,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Chaque palier qui constitue cet objectif représente une amélioration de votre état de santé. Plus le palier a un impact sur votre santé, plus la récompense sera élevée.',
                          style: TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 14,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 20),
                        sousObjectifs.isEmpty
                            ? Text('Aucun sous-objectif trouvé.')
                            : Column(
                                children: sousObjectifs.map((sousObjectif) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: ListObjectif(
                                          titre: sousObjectif['titre'],
                                          description:
                                              sousObjectif['description'],
                                          points: sousObjectif['points'],
                                          progression:
                                              sousObjectif['progression']
                                                  .toDouble(),
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              16), // Espace entre les sous-objectifs
                                    ],
                                  );
                                }).toList(),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}

class ListObjectif extends StatefulWidget {
  final String titre;
  final String description;
  final int points;
  final double progression;

  const ListObjectif({
    required this.titre,
    required this.description,
    required this.points,
    required this.progression,
  });

  @override
  _ListObjectifState createState() => _ListObjectifState();
}

class _ListObjectifState extends State<ListObjectif> {
  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        return ModaleConfirmationAchat(
          titre: widget.titre,
          points: widget.points,
          isCompleted: widget.progression == 1.0,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showModal(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFF8352FF)),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.titre,
                        style: TextStyle(
                          color: Color(0xFF222222),
                          fontSize: 16,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.description,
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
                const SizedBox(width: 16),
                if (widget.points > 0)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: ShapeDecoration(
                      color: Color(0xFFDAE0F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Text(
                      '+ ${widget.points}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF044BD9),
                        fontSize: 12,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                Container(
                  width: 24,
                  height: 24,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFDAE0F6),
                  ),
                  child: Icon(Icons.info, color: Color(0xFF044BD9)),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 5,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: MediaQuery.of(context)
                          .size
                          .width, // Contraindre la largeur
                      height: 5,
                      decoration: ShapeDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          (widget.progression), // Contraindre la largeur
                      height: 5,
                      decoration: ShapeDecoration(
                        color: Color(0xFF8352FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
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
