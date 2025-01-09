import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/action/button_state.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:hygie_mobile/commons/action/buttonWithIcon/button_with_icon.dart';

@UseCase(name: 'Primary with Icon Left', type: ButtonWithIcon)
Widget primaryButtonWithIconLeft(BuildContext context) {
  return ButtonWithIcon(
    text: 'Primary',
    state: ButtonState.primary,
    icon: const Icon(Icons.check, color: Colors.white),
    iconPosition: IconPosition.left,
  );
}

@UseCase(name: 'Primary with Icon Right', type: ButtonWithIcon)
Widget primaryButtonWithIconRight(BuildContext context) {
  return ButtonWithIcon(
    text: 'Primary',
    state: ButtonState.primary,
    icon: const Icon(Icons.check, color: Colors.white),
    iconPosition: IconPosition.right,
  );
}

@UseCase(name: 'Pressed with Icon Left', type: ButtonWithIcon)
Widget pressedButtonWithIconLeft(BuildContext context) {
  return ButtonWithIcon(
    text: 'Pressed',
    state: ButtonState.pressed,
    icon: const Icon(Icons.warning, color: Colors.white),
    iconPosition: IconPosition.left,
  );
}

@UseCase(name: 'Pressed with Icon Right', type: ButtonWithIcon)
Widget pressedButtonWithIconRight(BuildContext context) {
  return ButtonWithIcon(
    text: 'Pressed',
    state: ButtonState.pressed,
    icon: const Icon(Icons.warning, color: Colors.white),
    iconPosition: IconPosition.right,
  );
}

@UseCase(name: 'Disabled with Icon', type: ButtonWithIcon)
Widget disabledButtonWithIcon(BuildContext context) {
  return ButtonWithIcon(
    text: 'Disabled',
    state: ButtonState.disabled,
    icon: const Icon(Icons.block, color: Colors.white),
    iconPosition: IconPosition.left, // Par défaut à gauche
  );
}

@UseCase(name: 'Secondary with Icon', type: ButtonWithIcon)
Widget secondaryButtonWithIcon(BuildContext context) {
  return ButtonWithIcon(
    text: 'Secondary',
    state: ButtonState.secondary,
    icon: const Icon(Icons.info, color: Colors.black),
    iconPosition: IconPosition.left,
  );
}

@UseCase(name: 'Tertiary with Icon', type: ButtonWithIcon)
Widget tertiaryButtonWithIcon(BuildContext context) {
  return ButtonWithIcon(
    text: 'Tertiary',
    state: ButtonState.tertiary,
    icon: const Icon(Icons.star, color: Colors.black),
    iconPosition: IconPosition.right,
  );
}

