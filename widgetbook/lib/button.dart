import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:hygie_mobile/commons/action/primary/button.dart';

@UseCase(name: 'Primary', type: PrimaryButton)
Widget primaryButton(BuildContext context) {
  return PrimaryButton(
    text: 'Primary',
    state: ButtonState.primary,
  );
}

@UseCase(name: 'Pressed', type: PrimaryButton)
Widget pressedButton(BuildContext context) {
  return PrimaryButton(
    text: 'Pressed',
    state: ButtonState.pressed,
  );
}

@UseCase(name: 'Disabled', type: PrimaryButton)
Widget disabledButton(BuildContext context) {
  return PrimaryButton(
    text: 'Disabled',
    state: ButtonState.disabled,
  );
}