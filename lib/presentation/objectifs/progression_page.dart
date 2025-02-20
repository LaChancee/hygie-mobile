import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/header.dart';
import 'package:hygie_mobile/presentation/objectifs/modale_confirmation_achat.dart';

class ProgressionPage extends StatefulWidget {
  final String type;
  final String title;

  const ProgressionPage({required this.type, required this.title});

  @override
  _ProgressionPageState createState() => _ProgressionPageState();
}

class _ProgressionPageState extends State<ProgressionPage> {
  // Liste statique de sous-objectifs
  final List<Map<String, dynamic>> sousObjectifs = [
    {
      'titre': 'Baisse de la pression artérielle',
      'description': 'Palier atteint après 12 heures.',
      'points': 5,
      'progression': 1.0,
    },
    {
      'titre': 'Baisse de la pression artérielle',
      'description': 'Palier atteint après 24 heures.',
      'points': 0,
      'progression': 1.0,
    },
    {
      'titre': 'Lorem ipsum',
      'description': 'Palier atteint après 2 jours',
      'points': 20,
      'progression': 1.0,
    },
    {
      'titre': 'Baisse de la pression artérielle',
      'description': 'Palier atteint après 3 jours',
      'points': 0,
      'progression': 0.5,
    },
    {
      'titre': 'Baisse de la pression artérielle',
      'description': 'Palier atteint après 2 jours',
      'points': 0,
      'progression': 0.5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: ""), // Utilisation du header réutilisable
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
                        Navigator.pop(context); // Retour à la page précédente
                      },
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Mes objectifs',
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
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
                  ChaquePalierQuiConstitueCetObjectifReprSenteUneAmLiorationDeVotreTatDeSantPlusLePalierUnImpactSurVotreSantPlusLaRCompenseSeraLevE(),
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
                                    description: sousObjectif['description'],
                                    points: sousObjectif['points'],
                                    progression: sousObjectif['progression'].toDouble(),
                                  ),
                                ),
                                SizedBox(height: 16), // Espace entre les sous-objectifs
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

class ChaquePalierQuiConstitueCetObjectifReprSenteUneAmLiorationDeVotreTatDeSantPlusLePalierUnImpactSurVotreSantPlusLaRCompenseSeraLevE extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Chaque palier qui constitue cet objectif représente une amélioration de votre état de santé. Plus le palier a un impact sur votre santé, plus la récompense sera élevée.',
      style: TextStyle(
        color: Color(0xFF222222),
        fontSize: 14,
        fontFamily: 'DM Sans',
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.start,
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
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  decoration: BoxDecoration(),
                  child: FlutterLogo(),
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
                      width: MediaQuery.of(context).size.width, // Contraindre la largeur
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
                      width: MediaQuery.of(context).size.width * (widget.progression / 100), // Contraindre la largeur
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
