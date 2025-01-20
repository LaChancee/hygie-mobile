import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/ui/colors.dart';
import 'package:hygie_mobile/commons/action/button_state.dart';

enum ButtonSize { small, medium }

// Widget du bouton personnalisé
class ButtonWithoutIcon extends StatelessWidget {
  final String text;
  final ButtonState state;
  final ButtonSize size;

  const ButtonWithoutIcon({
    super.key,
    required this.text,
    required this.state,
    this.size = ButtonSize.medium, // Taille par défaut : medium
  });

  @override
  Widget build(BuildContext context) {
    // Définir les styles de taille selon ButtonSize
    double width, height, paddingHorizontal, paddingVertical, fontSize;

    switch (size) {
      case ButtonSize.small:

        paddingHorizontal = 16;
        paddingVertical = 8;
        fontSize = 14;
        break;
      case ButtonSize.medium:

        paddingHorizontal = 24;
        paddingVertical = 16;
        fontSize = 16;
        break;
    }

    // Sélection de la couleur de fond, du texte et d'autres styles selon l'état du bouton
    Color backgroundColor;
    Color textColor;
    bool isDisabled = false;

    switch (state) {
      case ButtonState.primary:
        backgroundColor = AppColors.primaryColor;
        textColor = Colors.white;
        break;
      case ButtonState.secondary:
        backgroundColor = AppColors.secondaryColor;
        textColor = Colors.white;
        break;
      case ButtonState.tertiary:
        backgroundColor = AppColors.tertiaryColor;
        textColor = Color(0xFF222222);
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
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal,
            vertical: paddingVertical,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999), // Bords arrondis
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor, // Couleur du texte selon l'état
            fontSize: fontSize,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
