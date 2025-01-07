import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:hygie_mobile/commons/action/button.dart';

@UseCase(name: 'Primary', type: PrimaryButton)
Widget primaryButton(BuildContext context) {
  return PrimaryButton(
    text: 'Primary',
    state: ButtonState.primary,
  );
}
@UseCase(name: 'Secondary', type: PrimaryButton)
Widget secondaryButton(BuildContext context) {
  return PrimaryButton(
    text: 'Secondary',
    state: ButtonState.secondary,
  );
}

@UseCase(name: 'Disabled', type: PrimaryButton)
Widget disabledButton(BuildContext context) {
  return PrimaryButton(
    text: 'Disabled',
    state: ButtonState.disabled,
  );
}