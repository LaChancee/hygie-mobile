import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/dependance_test_provider.dart';
import 'question1.dart';

class TestDependancePage extends StatefulWidget {
  const TestDependancePage({Key? key}) : super(key: key);

  @override
  State<TestDependancePage> createState() => _TestDependancePageState();
}

class _TestDependancePageState extends State<TestDependancePage> {
  // Index du test sélectionné, 0 pour tabac, 1 pour alcool
  int selectedTestIndex = 0;

  // Étape actuelle du test (0: Type, 1: Questions, 2: Validation)
  int currentStep = 0;

  // Progression dans l'étape actuelle (0.0 à 1.0)
  List<double> stepProgress = [
    1.0,
    0.0,
    0.0
  ]; // Type complété à 100%, autres à 0%

  // Liste des tests disponibles
  final List<Map<String, dynamic>> dependenceTests = [
    {
      'title': 'Test de dépendance au tabac',
      'points': '375',
      'description':
          'Fixez-vous des objectifs et obtenez des données plus détaillées.'
    },
    {
      'title': 'Test de dépendance à l\'alcool',
      'points': '375',
      'description':
          'Fixez-vous des objectifs et obtenez des données plus détaillées.'
    },
  ];

  void _onTestSelected(int index) {
    setState(() {
      selectedTestIndex = index;
    });
  }

  void _goToNextStep() {
    // Passage à l'étape suivante du test
    if (currentStep < 2) {
      setState(() {
        // Marquer l'étape actuelle comme complétée
        stepProgress[currentStep] = 1.0;
        // Avancer à l'étape suivante
        currentStep++;
        // Commencer la progression de la nouvelle étape
        stepProgress[currentStep] = 0.3; // Démarrer avec un peu de progression
      });

      // Si on passe de l'étape 0 (Type de dépendance) à l'étape 1 (Questions)
      if (currentStep == 1) {
        // Déterminer le type de dépendance
        String dependanceType = selectedTestIndex == 0 ? 'tabac' : 'alcool';

        // Initialiser le test dans le provider
        Provider.of<DependanceTestProvider>(context, listen: false)
            .initTest(dependanceType);

        // Naviguer vers la première question
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Question1Page(
              dependanceType: dependanceType,
            ),
          ),
        );
      }
    }

    // Pour la démonstration, afficher un message
    final selectedTest = dependenceTests[selectedTestIndex]['title'];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Test sélectionné: $selectedTest - Étape ${currentStep + 1}/3'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _incrementProgress() {
    if (currentStep < stepProgress.length) {
      setState(() {
        // Incrémenter la progression de l'étape actuelle de 25% (plafonné à 100%)
        stepProgress[currentStep] =
            (stepProgress[currentStep] + 0.25).clamp(0.0, 1.0);
      });
    }
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Steps
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: _buildStepIndicator('Type de dépendance',
                          0 <= currentStep, stepProgress[0]),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: _buildStepIndicator(
                          'Questions', 1 <= currentStep, stepProgress[1]),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: _buildStepIndicator(
                          'Validation', 2 <= currentStep, stepProgress[2]),
                    ),
                  ),
                ],
              ),
            ),

            // Text instruction
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                currentStep == 0
                    ? 'Choisissez le type de dépendance que vous souhaitez tester'
                    : currentStep == 1
                        ? 'Répondez aux questions du test'
                        : 'Vérifiez vos résultats',
                style: TextStyle(
                  color: Color(0xFF044BD9),
                  fontSize: 14,
                  fontFamily: 'DM sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Test cards list
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: List.generate(
                    dependenceTests.length,
                    (index) => Column(
                      children: [
                        GestureDetector(
                          onTap: () => _onTestSelected(index),
                          child: _buildDependenceCard(
                            title: dependenceTests[index]['title'],
                            isSelected: selectedTestIndex == index,
                            points: dependenceTests[index]['points'],
                            description: dependenceTests[index]['description'],
                          ),
                        ),
                        if (index < dependenceTests.length - 1)
                          const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Buttons at the bottom
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Bouton pour passer à l'étape suivante
                  ElevatedButton(
                    onPressed: _goToNextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF044BD9),
                      disabledBackgroundColor:
                          const Color(0xFF044BD9).withOpacity(0.5),
                      minimumSize: const Size(double.infinity, 53),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Text(
                      currentStep < 2 ? 'Poursuivre' : 'Terminer',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'DM sans',
                        fontWeight: FontWeight.w600,
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
          color: const Color(
              0xFFDAE0F6), // Utilise color au lieu de decoration pour éviter les bords arrondis
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

  Widget _buildDependenceCard({
    required String title,
    required bool isSelected,
    required String points,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isSelected
              ? [const Color(0xFFE6EEFF), const Color(0xFFEDE6FF)]
              : [const Color(0xFFF0F5FF), const Color(0xFFF5F8FC)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: isSelected
            ? Border.all(width: 1, color: const Color(0xFF044BD9))
            : null,
        boxShadow: isSelected
            ? [
                const BoxShadow(
                  color: Color(0x1E06214F),
                  blurRadius: 12,
                  offset: Offset(0, 0),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left content with title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF6C33FF),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DM sans',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 14,
                    fontFamily: 'DM sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          // Points badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF044BD9), Color(0xFF6C33FF)],
              ),
              borderRadius: BorderRadius.circular(999),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1E072250),
                  blurRadius: 12,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  points,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'DM sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 16,
                  height: 16,
                  child: Image.asset(
                    'assets/images/hycoins.png',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
