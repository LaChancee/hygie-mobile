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

@UseCase(name: 'Outlined', type: OutlineButton)
Widget outlinePrimaryButton(BuildContext context) {
  return OutlineButton(
  text: 'Primary',
      state: ButtonState.primary
  );
}
@UseCase(name: 'OutlinedPressed', type: OutlineButton)
Widget outlinePressedPrimaryButton(BuildContext context) {
  return OutlineButton(
  text: 'Pressed',
      state: ButtonState.primary
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

@UseCase(name: 'Outlined', type: OutlineButton)
Widget outlineSecondaryButton(BuildContext context) {
  return OutlineButton(
      text: 'Secondary',
      state: ButtonState.secondary
  );
}
@UseCase(name: 'OutlinedPressed', type: OutlineButton)
Widget outlinePressedSecondaryButton(BuildContext context) {
  return OutlineButton(
      text: 'Pressed',
      state: ButtonState.secondaryPressed
  );
}
