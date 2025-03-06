import 'package:flutter/material.dart';
import '../journal/modale_add_activity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CardsContext extends StatefulWidget {
  @override
  _CardsContextState createState() => _CardsContextState();
}

class _CardsContextState extends State<CardsContext> {
  int _daysWithoutSmokingConsumption = 0;
  int _daysWithoutAlcoholConsumption = 0;
  bool _isLoadingSmokingData = true;
  bool _isLoadingAlcoholData = true;
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _loadConsumptionData('tabac');
    _loadConsumptionData('alcool');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadConsumptionData(String type) async {
    if (type == 'tabac') {
      setState(() {
        _isLoadingSmokingData = true;
      });
    } else {
      setState(() {
        _isLoadingAlcoholData = true;
      });
    }

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        if (type == 'tabac') {
          setState(() {
            _daysWithoutSmokingConsumption = 0;
            _isLoadingSmokingData = false;
          });
        } else {
          setState(() {
            _daysWithoutAlcoholConsumption = 0;
            _isLoadingAlcoholData = false;
          });
        }
        return;
      }

      // Récupérer la dernière consommation du type spécifié
      final querySnapshot = await FirebaseFirestore.instance
          .collection('consommations')
          .where('userId', isEqualTo: userId)
          .where('type', isEqualTo: type == 'tabac' ? 'Tabac' : 'Alcool')
          .orderBy('date', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // Si aucune consommation enregistrée, on considère
        // que l'utilisateur est "clean" depuis son inscription
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userDoc.exists && userDoc.data()!.containsKey('createdAt')) {
          final createdAt = userDoc.data()!['createdAt'] as Timestamp;
          final daysSinceCreation =
              DateTime.now().difference(createdAt.toDate()).inDays;

          if (type == 'tabac') {
            setState(() {
              _daysWithoutSmokingConsumption = daysSinceCreation;
              _isLoadingSmokingData = false;
            });
          } else {
            setState(() {
              _daysWithoutAlcoholConsumption = daysSinceCreation;
              _isLoadingAlcoholData = false;
            });
          }
        } else {
          // Si on ne peut pas déterminer la date d'inscription, on met 0
          if (type == 'tabac') {
            setState(() {
              _daysWithoutSmokingConsumption = 0;
              _isLoadingSmokingData = false;
            });
          } else {
            setState(() {
              _daysWithoutAlcoholConsumption = 0;
              _isLoadingAlcoholData = false;
            });
          }
        }
      } else {
        // Calculer le nombre de jours depuis la dernière consommation
        final lastConsumption = querySnapshot.docs.first.data();
        final lastDate = DateTime.parse(lastConsumption['date']);
        final daysDifference = DateTime.now().difference(lastDate).inDays;

        if (type == 'tabac') {
          setState(() {
            _daysWithoutSmokingConsumption = daysDifference;
            _isLoadingSmokingData = false;
          });
        } else {
          setState(() {
            _daysWithoutAlcoholConsumption = daysDifference;
            _isLoadingAlcoholData = false;
          });
        }
      }
    } catch (e) {
      print('Erreur lors du chargement des données de $type: $e');
      if (type == 'tabac') {
        setState(() {
          _daysWithoutSmokingConsumption = 0;
          _isLoadingSmokingData = false;
        });
      } else {
        setState(() {
          _daysWithoutAlcoholConsumption = 0;
          _isLoadingAlcoholData = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          height: 240, // Augmenter la hauteur de 200 à 240
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              // Carte Non-fumeur
              _buildContextCard(
                screenWidth,
                'Non-fumeur depuis :',
                _daysWithoutSmokingConsumption,
                _isLoadingSmokingData,
                'tabac',
              ),
              // Carte Sobre
              _buildContextCard(
                screenWidth,
                'Sobre depuis :',
                _daysWithoutAlcoholConsumption,
                _isLoadingAlcoholData,
                'alcool',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20), // Augmentation de l'espace
        // Indicateurs de page
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            2,
            (index) => Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? Color(0xFF044BD9)
                    : Color(0xFFDAE0F6),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10), // Espace supplémentaire en bas
      ],
    );
  }

  Widget _buildContextCard(
    double screenWidth,
    String title,
    int daysCount,
    bool isLoading,
    String type,
  ) {
    // Adaptation plus agressive du texte sur les boutons
    String buttonText;
    // Logique plus fine pour adapter le texte à la taille de l'écran
    if (screenWidth < 300) {
      buttonText = '+'; // Juste l'icône suffira pour les très petits écrans
    } else if (screenWidth < 340) {
      buttonText = 'Conso';
    } else if (screenWidth < 380) {
      buttonText = 'Conso.';
    } else {
      buttonText = 'Consommation';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: screenWidth > 600 ? 400 : double.infinity,
        padding: const EdgeInsets.all(20), // Réduire le padding de 24 à 20
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Ajouter cette ligne
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            isLoading
                ? Container(
                    height: 40, // Réduire de 48 à 40
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF044BD9),
                      ),
                    ),
                  )
                : Text(
                    '$daysCount jour${daysCount > 1 ? 's' : ''}',
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 42, // Réduire de 48 à 42
                      fontWeight: FontWeight.w700,
                    ),
                  ),
            const SizedBox(height: 12), // Réduire de 16 à 12
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Bouton "Bilan"
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.bar_chart,
                      color: Color(0xFF044BD9),
                      size: screenWidth < 320
                          ? 16
                          : (screenWidth < 360 ? 18 : 24),
                    ),
                    label: Text(
                      'Bilan',
                      style: TextStyle(
                        color: Color(0xFF044BD9),
                        fontSize: screenWidth < 320
                            ? 12
                            : (screenWidth < 360 ? 13 : 16),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFF044BD9), width: 2),
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: screenWidth < 320
                            ? 4
                            : (screenWidth < 360 ? 8 : 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Bouton "Consommation"
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Ouvrir la modale d'ajout d'activité
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: ModaleAddActivity(),
                        ),
                      ).then((_) {
                        // Recharger les données après avoir fermé la modale
                        _loadConsumptionData('tabac');
                        _loadConsumptionData('alcool');
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      // Réduire davantage la taille de l'icône pour libérer de l'espace
                      size: screenWidth < 320 ? 14 : (screenWidth < 360 ? 16 : 20),
                    ),
                    label: Text(
                      // Éviter que le texte ne soit coupé
                      buttonText,
                      overflow: TextOverflow.visible,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: screenWidth < 320 ? 10 : (screenWidth < 360 ? 12 : 14),
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF044BD9),
                      shape: StadiumBorder(),
                      // Réduire le padding pour donner plus d'espace au texte
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: screenWidth < 320
                            ? 4
                            : (screenWidth < 360 ? 8 : 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
