import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/ui/colors.dart';

// Définir les différents états du bouton
enum ButtonState {
  primary,
  pressed,
  disabled,
}

// Widget du bouton personnalisé
class PrimaryButton extends StatelessWidget {
  final String text;
  final ButtonState state;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    // Sélection de la couleur de fond, du texte et d'autres styles selon l'état du bouton
    Color backgroundColor;
    Color textColor;
    bool isDisabled = false;

    switch (state) {
      case ButtonState.primary:
        backgroundColor = AppColors.primaryColor;
        textColor = Colors.white;
        break;
      case ButtonState.pressed:
        backgroundColor = Color(0xFF0A409E);
        textColor = Colors.white;
        break;
      case ButtonState.disabled:
        backgroundColor = Color(0xFFBFBFBF);
        textColor = Colors.white;
        isDisabled = true;
        break;
    }

    return AnimatedOpacity(
      opacity: isDisabled ? 0.6 : 1.0, // Animation de l'opacité pour le mode disabled
      duration: Duration(milliseconds: 300), // Durée de l'animation
      child: ElevatedButton(
        onPressed: isDisabled ? null : () {}, // Si le bouton est disabled, pas d'action
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // Couleur de fond selon l'état
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999), // Bords arrondis
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor, // Couleur du texte selon l'état
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
