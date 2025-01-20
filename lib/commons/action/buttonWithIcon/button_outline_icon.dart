import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/ui/colors.dart';

enum ButtonState { primary, secondary,tertiary,pressed, disabled }
enum ButtonIconPosition { left, right }

class OutlineButtonWithIcon extends StatelessWidget {
  final String text;
  final ButtonState state;
  final ButtonIconPosition iconPosition;
  final Icon icon;
  final VoidCallback? onPressed;

  const OutlineButtonWithIcon({
    super.key,
    required this.text,
    required this.state,
    required this.icon,
    required this.iconPosition,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Définir les styles selon l'état du bouton
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
        textColor =  AppColors.tertiaryColor;
        break;
      case ButtonState.pressed:
        borderColor = const Color(0xFF002F92);
        textColor = const Color(0xFF002F92);
        break;
      case ButtonState.disabled:
        borderColor = const Color(0xFFBFBFBF);
        textColor = const Color(0xFFBFBFBF);
        isDisabled = true;
        break;
    }

    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        backgroundColor: Colors.transparent,
        foregroundColor: textColor,
        elevation: 0,
        side: BorderSide(width: 2, color: borderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: iconPosition == ButtonIconPosition.left
            ? [
          icon,
          const SizedBox(width: 8), // Espacement entre l'icône et le texte
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'DM Sans',
              color: textColor,
            ),
          ),
        ]
            : [
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'DM Sans',
              color: textColor,
            ),
          ),
          const SizedBox(width: 8), // Espacement entre le texte et l'icône
          icon,
        ],
      ),
    );
  }
}
