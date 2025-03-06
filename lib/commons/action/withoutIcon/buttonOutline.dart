import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/ui/colors.dart';
import 'package:hygie_mobile/commons/action/button_state.dart';

enum ButtonSize { small, medium }

// Widget du bouton Outlined personnalisé
class OutlineButton extends StatelessWidget {
  final String text;
  final ButtonState state;
  final ButtonSize size;

  const OutlineButton({
    super.key,
    required this.text,
    required this.state,
    this.size = ButtonSize.medium, // Taille par défaut : medium
  });

  @override
  Widget build(BuildContext context) {
    // Définir les styles de taille selon ButtonSize
    double paddingHorizontal, paddingVertical, fontSize;

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

    // Sélection de la couleur de la bordure et du texte selon l'état du bouton
    Color borderColor;
    Color textColor;
    bool isDisabled = false;

    switch (state) {
      case ButtonState.primary:
        borderColor = AppColors.primaryColor;
        textColor = AppColors.primaryColor;
        break;
      case ButtonState.secondary:
        borderColor = AppColors.secondaryColor;
        textColor = AppColors.secondaryColor;
        break;
      case ButtonState.tertiary:
        borderColor = AppColors.tertiaryColor;
        textColor = AppColors.tertiaryColor;
        break;
      case ButtonState.disabled:
        borderColor = Color(0xFFBFBFBF);
        textColor = Color(0xFFBFBFBF);
        isDisabled = true;
        break;
    }

    return AnimatedOpacity(
      opacity: isDisabled ? 0.6 : 1.0, // Animation de l'opacité pour le mode disabled
      duration: const Duration(milliseconds: 300), // Durée de l'animation
      child: ElevatedButton(
        onPressed: isDisabled ? null : () {}, // Si le bouton est disabled, pas d'action
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            color: borderColor, // Couleur de la bordure selon l'état
            width: 2, // Largeur de la bordure
          ),
          backgroundColor: Colors.transparent, // Fond transparent
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal,
            vertical: paddingVertical,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999), // Bords arrondis
          ),
          elevation: 0, // Suppression de l'ombre
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
