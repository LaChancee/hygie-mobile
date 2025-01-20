import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/ui/colors.dart';


enum IconButtonState {
  primary,
  pressed,
  secondary,
  tertiary,
  disabled,
}
enum IconButtonSize { small, medium }

class IconButtonCustom extends StatelessWidget {
  final Icon icon;
  final IconButtonState state;
  final VoidCallback? onPressed;
  final IconButtonSize size;

  const IconButtonCustom({
    super.key,
    required this.icon,
    required this.state,
    this.onPressed,
    this.size = IconButtonSize.medium, // Taille par défaut
  });

  @override
  Widget build(BuildContext context) {
    // Dimensions et styles selon la taille
    double width, height, padding;

    switch (size) {
      case IconButtonSize.small:
        width = 72;
        height = 37;
        padding = 8;
        break;
      case IconButtonSize.medium:
        width = 72;
        height = 53;
        padding = 16;
        break;
    }

    // Styles selon l'état
    Color backgroundColor;
    bool isDisabled = false;

    switch (state) {
      case IconButtonState.primary:
        backgroundColor = AppColors.primaryColor;
        break;
      case IconButtonState.pressed:
        backgroundColor = const Color(0xFF0A409E);
        break;
      case IconButtonState.secondary:
        backgroundColor = AppColors.secondaryColor;
        break;
      case IconButtonState.tertiary:
        backgroundColor = AppColors.tertiaryColor;
        break;
      case IconButtonState.disabled:
        backgroundColor = Colors.grey;
        isDisabled = true;
        break;
    }

    return AnimatedOpacity(
      opacity: isDisabled ? 0.6 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: isDisabled ? null : onPressed,
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.all(padding),
          decoration: ShapeDecoration(
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          child: Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}

