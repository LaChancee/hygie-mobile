import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:hygie_mobile/commons/action/button_state.dart';
import 'package:hygie_mobile/commons/action/withoutIcon/button.dart';

@UseCase(name: 'Primary Small', type: ButtonWithoutIcon)
Widget primarySmallButton(BuildContext context) {
  return ButtonWithoutIcon(
    text: 'Primary S',
    state: ButtonState.primary,
    size: ButtonSize.small,
  );
}

@UseCase(name: 'Secondary Small', type: ButtonWithoutIcon)
Widget secondarySmallButton(BuildContext context) {
  return ButtonWithoutIcon(
    text: 'Secondary S',
    state: ButtonState.secondary,
    size: ButtonSize.small,
  );
}

@UseCase(name: 'Tertiary Small', type: ButtonWithoutIcon)
Widget tertiarySmallButton(BuildContext context) {
  return ButtonWithoutIcon(
    text: 'Tertiary S',
    state: ButtonState.tertiary,
    size: ButtonSize.small,
  );
}

@UseCase(name: 'Disabled Small', type: ButtonWithoutIcon)
Widget disabledSmallButton(BuildContext context) {
  return ButtonWithoutIcon(
    text: 'Disabled S',
    state: ButtonState.disabled,
    size: ButtonSize.small,
  );
}
