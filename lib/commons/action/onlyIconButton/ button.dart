import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/ui/colors.dart';


enum IconButtonState {
  primary,
  pressed,
  secondary,
  tertiary,
  disabled,
}

class IconButtonCustom extends StatelessWidget {
  final Icon icon;
  final IconButtonState state;
  final VoidCallback? onPressed;

  const IconButtonCustom({
    super.key,
    required this.icon,
    required this.state,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Détermine les styles selon l'état
    Color backgroundColor;
    bool isDisabled = false;

    switch (state) {
      case IconButtonState.primary:
        backgroundColor = AppColors.primaryColor;
        break;
      case IconButtonState.pressed:
        backgroundColor = const Color(0xFF0A409E); // Couleur foncée pour "pressed"
        break;
      case IconButtonState.secondary:
        backgroundColor = AppColors.secondaryColor;
        break;
      case IconButtonState.tertiary:
        backgroundColor = AppColors.tertiaryColor;
        break;
      case IconButtonState.pressed:
        backgroundColor = const Color(0xFF0A409E); // Couleur foncée pour "pressed"
        break;
      case IconButtonState.disabled:
        backgroundColor = Colors.grey;
        isDisabled = true;
        break;
    }

    return AnimatedOpacity(
      opacity: isDisabled ? 0.6 : 1.0, // Réduction de l'opacité si désactivé
      duration: const Duration(milliseconds: 300), // Animation fluide
      child: GestureDetector(
        onTap: isDisabled ? null : onPressed, // Désactive l'action si nécessaire
        child: Container(
          width: 72,
          height: 53,
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999), // Coins arrondis
            ),
          ),
          child: Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: icon, // Icône au centre
            ),
          ),
        ),
      ),
    );
  }
}
