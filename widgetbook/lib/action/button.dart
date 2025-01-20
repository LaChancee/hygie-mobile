import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/action/button_state.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:hygie_mobile/commons/action/withoutIcon//button.dart';

@UseCase(name: 'Primary', type: ButtonWithoutIcon)
Widget primaryButton(BuildContext context) {
  return ButtonWithoutIcon(
    text: 'Primary',
    state: ButtonState.primary,
    size: ButtonSize.medium,
  );
}


@UseCase(name: 'Disabled', type: ButtonWithoutIcon)
Widget disabledButton(BuildContext context) {
  return ButtonWithoutIcon(
    text: 'Disabled',
    state: ButtonState.disabled,
    size: ButtonSize.medium,

  );
}
@UseCase(name: 'Secondary', type: ButtonWithoutIcon)
Widget secondaryButton(BuildContext context) {
  return ButtonWithoutIcon(
    text: 'Secondary',
    state: ButtonState.secondary,
    size: ButtonSize.medium,

  );
}


@UseCase(name: 'Tertiary', type: ButtonWithoutIcon)
Widget tertiaryButton(BuildContext context) {
  return ButtonWithoutIcon(
    text: 'Tertiary',
    state: ButtonState.tertiary,
    size: ButtonSize.medium,

  );
}



