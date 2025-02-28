import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/questionnaire/step3.dart';

// Widget InputSelect réutilisable
class InputSelect extends StatefulWidget {
  final List<String> options;
  final String label;
  final String initialValue;
  final ValueChanged<String>? onChanged;

  const InputSelect({
    Key? key,
    required this.options,
    required this.label,
    required this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  _InputSelectState createState() => _InputSelectState();
}

class _InputSelectState extends State<InputSelect> {
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          widget.label,
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 16,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10),
        // Select Button (Dropdown)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Color(0xFFDFE5ED),
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedOption,
              icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              isExpanded: true,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedOption = newValue;
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged!(newValue);
                  }
                }
              },
              items: widget.options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF222222),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

// Écran Step3
class Step2 extends StatefulWidget {
  @override
  _Step2State createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  String selectedOption = "Une fois par semaine"; // Option par défaut

  final List<String> options = [
    "Une fois par semaine",
    "2 à 3 fois par semaine",
    "4 à 5 fois par semaine",
    "Tous les jours"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),

                // Icône retour
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back, color: Colors.black, size: 32),
                ),

                SizedBox(height: 30),

                // Titre principal
                Text(
                  'Pour commencer',
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 32,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 16),

                // Texte descriptif
                Text(
                  'En moyenne, combien de jours par semaine fumez-vous ?',
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 14,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 20),

                // Sélecteur InputSelect
                InputSelect(
                  label: "Consommation par semaine",
                  initialValue: selectedOption,
                  options: options,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),

                SizedBox(height: 40),

                // Bouton "Suivant"
                GestureDetector(
                  onTap: () {
                    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Step3()), // Naviguer vers Step2
          );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFF044BD9),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Center(
                      child: Text(
                        'Suivant',
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

                SizedBox(height: 30), // Ajout d’un espace en bas
              ],
            ),
          ),
        ),
      ),
    );
  }
}
