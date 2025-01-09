import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/ui/colors.dart';
import 'package:hygie_mobile/commons/action/button_state.dart';


enum IconPosition {
  left,
  right,
}

class ButtonWithIcon extends StatelessWidget {
  final String text;
  final ButtonState state;
  final Widget? icon;
  final IconPosition iconPosition;

  const ButtonWithIcon({
    super.key,
    required this.text,
    required this.state,
    this.icon,
    this.iconPosition = IconPosition.left,
  });

  @override
  Widget build(BuildContext context) {
    // Définir les styles selon l'état
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
      case ButtonState.secondary:
        backgroundColor = AppColors.secondaryColor;
        textColor = Colors.white;
        break;
      case ButtonState.secondaryPressed:
        backgroundColor = Color(0xFF6C33FF);
        textColor = Colors.white;
        break;
      case ButtonState.tertiary:
        backgroundColor = AppColors.tertiaryColor;
        textColor = Color(0xFF222222);
        break;
      case ButtonState.tertiaryPressed:
        backgroundColor = Color(0xFF59E635);
        textColor = Color(0xFF222222);
        break;
      case ButtonState.disabled:
        backgroundColor = Color(0xFFBFBFBF);
        textColor = Colors.white;
        isDisabled = true;
        break;
    }

    return ElevatedButton(
      onPressed: isDisabled ? null : () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null && iconPosition == IconPosition.left) ...[
            icon!,
            const SizedBox(width: 8), // Espacement entre l'icône et le texte
          ],
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'DM Sans',
            ),
          ),
          if (icon != null && iconPosition == IconPosition.right) ...[
            const SizedBox(width: 8), // Espacement entre le texte et l'icône
            icon!,
          ],
        ],
      ),
    );
  }
}
