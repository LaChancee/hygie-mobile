import 'package:flutter/material.dart';

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
        // Label du champ
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

        // Conteneur du champ de sélection
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
