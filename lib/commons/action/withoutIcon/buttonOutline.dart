import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/ui/colors.dart';
import 'package:hygie_mobile/commons/action/button_state.dart';


// Widget du bouton personnalisé
class OutlineButton extends StatelessWidget {
  final String text;
  final ButtonState state;

  const OutlineButton({
    super.key,
    required this.text,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    // Sélection de la couleur de la bordure, du texte et d'autres styles selon l'état du bouton
    Color borderColor;
    Color textColor;
    bool isDisabled = false;

    switch (state) {
      case ButtonState.primary:
        borderColor = AppColors.primaryColor;
        textColor = AppColors.primaryColor;
        break;
      case ButtonState.pressed:
        borderColor = Color(0xFF044BD9);
        textColor = Color(0xFF044BD9);
        break;
      case ButtonState.secondary:
        borderColor = AppColors.secondaryColor;
        textColor = AppColors.secondaryColor;
        break;
      case ButtonState.secondaryPressed:
        borderColor = Color(0xFF6C33FF);
        textColor = Color(0xFF6C33FF);
        break;
      case ButtonState.tertiary:
        borderColor = AppColors.tertiaryColor;
        textColor = AppColors.tertiaryColor;
        break;
      case ButtonState.tertiaryPressed:
        borderColor = Color(0xFF59E635);
        textColor = Color(0xFF59E635);
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
            width: 2,
          ),
          backgroundColor: Colors.transparent, // Fond transparent pour le bouton outlined
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
            fontSize: 16,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
