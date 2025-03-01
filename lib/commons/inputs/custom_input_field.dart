import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String? initialValue;
  final String? hintText;
  final String helpText;
  final ValueChanged<String>? onChanged;

  const CustomInputField({
    super.key,
    required this.label,
    this.isRequired = false,
    this.initialValue,
    this.hintText,
    required this.helpText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label + Asterisk (si requis)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 18,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (isRequired)
                const Text(
                  '*',
                  style: TextStyle(
                    color: Color(0xFFBF5102),
                    fontSize: 18,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),

          // Input Field
          Container(
            width: double.infinity,
            height: 56,
            decoration: ShapeDecoration(
              color: const Color(0xFFDFE6EE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: TextFormField(
              initialValue: initialValue,
              onChanged: onChanged,
              style: const TextStyle(
                color: Color(0xFF222222),
                fontSize: 16,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: hintText ?? '',
                hintStyle: const TextStyle(
                  color: Color(0xFF8A8A8A),
                  fontSize: 16,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ),
          const SizedBox(height: 4),

          // Help Text
          Text(
            helpText,
            style: const TextStyle(
              color: Color(0xFF222222),
              fontSize: 12,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w400,
              height: 1.31,
            ),
          ),
        ],
      ),
    );
  }
}
