import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/action/button_state.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:hygie_mobile/commons/action/withoutIcon//button.dart';
import 'package:hygie_mobile/commons/action/withoutIcon/buttonOutline.dart';

@UseCase(name: 'Primary', type: ButtonWithoutIcon)
Widget primaryButton(BuildContext context) {
  return ButtonWithoutIcon(
    text: 'Primary',
    state: ButtonState.primary,
  );
}

@UseCase(name: 'Pressed', type: ButtonWithoutIcon)
Widget pressedButton(BuildContext context) {
  return ButtonWithoutIcon(
    text: 'Pressed',
    state: ButtonState.pressed,
  );
}

@UseCase(name: 'Disabled', type: ButtonWithoutIcon)
Widget disabledButton(BuildContext context) {
  return ButtonWithoutIcon(
    text: 'Disabled',
    state: ButtonState.disabled,
  );
}
@UseCase(name: 'Secondary', type: ButtonWithoutIcon)
Widget secondaryButton(BuildContext context) {
  return ButtonWithoutIcon(
    text: 'Secondary',
    state: ButtonState.secondary,
  );
}

@UseCase(name: 'SecondaryPressed', type: ButtonWithoutIcon)
Widget secondaryPressedButton(BuildContext context) {
  return ButtonWithoutIcon(
    text: 'Pressed',
    state: ButtonState.secondaryPressed,
  );
}

@UseCase(name: 'Tertiary', type: ButtonWithoutIcon)
Widget tertiaryButton(BuildContext context) {
  return ButtonWithoutIcon(
    text: 'Tertiary',
    state: ButtonState.tertiary,
  );
}

@UseCase(name: 'TertiaryPressed', type: ButtonWithoutIcon)
Widget tertiaryPressedButton(BuildContext context) {
  return ButtonWithoutIcon(
    text: 'Pressed',
    state: ButtonState.tertiaryPressed,
  );
}

