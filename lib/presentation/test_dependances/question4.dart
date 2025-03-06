import 'package:flutter/material.dart';
import 'question5.dart';

class Question4Page extends StatefulWidget {
  final String dependanceType; // 'tabac' ou 'alcool'

  const Question4Page({Key? key, required this.dependanceType})
      : super(key: key);

  @override
  State<Question4Page> createState() => _Question4PageState();
}

class _Question4PageState extends State<Question4Page> {
  int? selectedOption;

  String getQuestionText() {
    if (widget.dependanceType == 'tabac') {
      return 'Combien de cigarettes fumez-vous par jour, en moyenne ?';
    } else {
      return 'Combien de verres d\'alcool consommez-vous par jour, en moyenne ?';
    }
  }

  List<String> getOptions() {
    if (widget.dependanceType == 'tabac') {
      return ['10 ou moins', 'entre 11 et 20', 'entre 21 et 30', '31 ou plus'];
    } else {
      return ['1 ou 2', '3 ou 4', '5 ou 6', '7 ou plus'];
    }
  }

  void _selectOption(int index) {
    setState(() {
      selectedOption = index;
    });
  }

  void _goToNextQuestion() {
    // Navigation vers la question suivante
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Question5Page(
          dependanceType: widget.dependanceType,
        ),
      ),
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
                      child:
                          _buildStepIndicator('Type de dépendance', true, 1.0),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: _buildStepIndicator('Questions', true,
                          1.0), // Progression à 100% pour la dernière question
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: _buildStepIndicator('Résultat', false, 0.0),
                    ),
                  ),
                ],
              ),
            ),

            // Question
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                getQuestionText(),
                style: const TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 20,
                  fontFamily: 'DM sans',
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),

            // Options
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: List.generate(
                    getOptions().length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: _buildOptionCard(
                        getOptions()[index],
                        isSelected: selectedOption == index,
                        onTap: () => _selectOption(index),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Next button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: selectedOption != null ? _goToNextQuestion : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF044BD9),
                  disabledBackgroundColor:
                      const Color(0xFF044BD9).withOpacity(0.5),
                  minimumSize: const Size(double.infinity, 53),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: const Text(
                  'Suivant',
                  style: TextStyle(
                    color: Colors.white,
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

  Widget _buildOptionCard(String text,
      {required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xFFDDD4FF) : const Color(0xFFDFE5EE),
          shape: RoundedRectangleBorder(
            side: isSelected
                ? const BorderSide(width: 1, color: Color(0xFF8352FF))
                : BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color:
                isSelected ? const Color(0xFF8352FF) : const Color(0xFF222222),
            fontSize: 14,
            fontFamily: 'DM sans',
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
