import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/dependance_test_provider.dart';
import '../../data/models/dependance_test.dart';
import '../../data/services/hycoins_service.dart';
import '../../widgets/notification_gain.dart';
import 'proposition.dart';

class ResultatDependancePage extends StatefulWidget {
  final String dependanceType; // 'tabac' ou 'alcool'

  const ResultatDependancePage({
    Key? key,
    required this.dependanceType,
  }) : super(key: key);

  @override
  State<ResultatDependancePage> createState() => _ResultatDependancePageState();
}

class _ResultatDependancePageState extends State<ResultatDependancePage> {
  DependanceTest? _test;
  bool _isLoading = true;
  int _hycoinsBalance = 0;

  @override
  void initState() {
    super.initState();
    _loadTestResult();
    _loadHyCoinsBalance();
  }

  Future<void> _loadHyCoinsBalance() async {
    try {
      final hyCoinsService = HyCoinsService();
      final balance = await hyCoinsService.getBalance();
      setState(() {
        _hycoinsBalance = balance;
      });
    } catch (e) {
      print("Erreur lors du chargement du solde HyCoins: $e");
    }
  }

  Future<void> _loadTestResult() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Soumettre le test pour enregistrer les données
      final provider =
          Provider.of<DependanceTestProvider>(context, listen: false);
      final test = await provider.submitTest();

      setState(() {
        _test = test;
        _isLoading = false;
      });

      // Afficher la notification de récompense
      _showRewardNotification();
    } catch (e) {
      print("Erreur lors du chargement des résultats: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showRewardNotification() {
    // Utiliser la nouvelle notification animée
    showGainNotification(
      context,
      message: 'Test de dépendance réussi !',
      amount: 375,
      icon: Icons.check_circle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Test de dépendance',
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  '$_hycoinsBalance',
                  style: const TextStyle(
                    color: Color(0xFF044BD9),
                    fontSize: 16,
                    fontFamily: 'DM sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Image.asset(
                  'assets/images/hycoins.png',
                  width: 20,
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  // Progress Steps
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: _buildStepIndicator(
                                'Type de dépendance', false, 1.0),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: _buildStepIndicator('Questions', false, 1.0),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: _buildStepIndicator('Résultat', true, 1.0),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Titre du résultat
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    child: Text(
                      'Voici votre niveau de dépendance au ${widget.dependanceType}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF044BD9),
                        fontSize: 20,
                        fontFamily: 'DM sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  // Barre de progression
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        // Barre de progression
                        Container(
                          height: 16,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDAE0F6), // Couleur de fond
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Stack(
                                children: [
                                  Container(
                                    height: 16,
                                    width: constraints.maxWidth *
                                        (_test?.score ?? 0) /
                                        100, // Largeur proportionnelle au score
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF044BD9),
                                          Color(0xFF8352FF)
                                        ],
                                        begin: Alignment(1.0, 0.0),
                                        end: Alignment(-1.0, 0.0),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Informations de score
                        Column(
                          children: [
                            const Text(
                              'Votre dépendance s\'élève à un taux de :',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF044BD9),
                                fontSize: 12,
                                fontFamily: 'DM sans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '${_test?.score ?? 0} %',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF044BD9),
                                fontSize: 20,
                                fontFamily: 'DM sans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Ajout du niveau de dépendance
                            Text(
                              'Niveau : ${_test?.level ?? "Non déterminé"}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF044BD9),
                                fontSize: 16,
                                fontFamily: 'DM sans',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Image ou graphique
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/images/illustration-success.png',
                        width: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // Boutons de navigation
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Bouton "Voir les programmes"
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigation vers les programmes
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PropositionPage(
                                    dependanceType: widget.dependanceType,
                                    score: _test?.score ?? 0,
                                  ),
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
                              'Voir les programmes',
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
                        // Bouton "Retourner sur la page d'accueil"
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              // Retour à la page principale
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 2, color: Color(0xFF044BD9)),
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
                ],
              ),
      ),
    );
  }

  Widget _buildStepIndicator(String label, bool isActive, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Barre de progression
        Container(
          height: 6,
          width: double.infinity,
          color: const Color(0xFFDAE0F6),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  AnimatedContainer(
                    width: constraints.maxWidth * progress,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF044BD9),
                    ),
                    duration: const Duration(milliseconds: 500),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        // Étiquette
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF044BD9) : const Color(0xFFDAE0F6),
            fontSize: 12,
            fontFamily: 'DM sans',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
