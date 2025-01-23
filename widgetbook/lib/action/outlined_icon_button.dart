import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:hygie_mobile/commons/ui/colors.dart';
import 'package:hygie_mobile/commons/action/button_state.dart';
import 'package:hygie_mobile/commons/action/withoutIcon/buttonOutline.dart';

/// **Small Buttons**
@UseCase(name: 'Primary Small', type: OutlineButton)
Widget primarySmallOutlineButton(BuildContext context) {
  return OutlineButton(
    text: 'Primary',
    state: ButtonState.primary,
    size: ButtonSize.small,
  );
}

@UseCase(name: 'Secondary Small', type: OutlineButton)
Widget secondarySmallOutlineButton(BuildContext context) {
  return OutlineButton(
    text: 'Secondary',
    state: ButtonState.secondary,
    size: ButtonSize.small,
  );
}

@UseCase(name: 'Tertiary Small', type: OutlineButton)
Widget tertiarySmallOutlineButton(BuildContext context) {
  return OutlineButton(
    text: 'Tertiary',
    state: ButtonState.tertiary,
    size: ButtonSize.small,
  );
}

@UseCase(name: 'Disabled Small', type: OutlineButton)
Widget disabledSmallOutlineButton(BuildContext context) {
  return OutlineButton(
    text: 'Disabled',
    state: ButtonState.disabled,
    size: ButtonSize.small,
  );
}

/// **Medium Buttons**
@UseCase(name: 'Primary Medium', type: OutlineButton)
Widget primaryMediumOutlineButton(BuildContext context) {
  return OutlineButton(
    text: 'Primary',
    state: ButtonState.primary,
    size: ButtonSize.medium,
  );
}

@UseCase(name: 'Secondary Medium', type: OutlineButton)
Widget secondaryMediumOutlineButton(BuildContext context) {
  return OutlineButton(
    text: 'Secondary',
    state: ButtonState.secondary,
    size: ButtonSize.medium,
  );
}

@UseCase(name: 'Tertiary Medium', type: OutlineButton)
Widget tertiaryMediumOutlineButton(BuildContext context) {
  return OutlineButton(
    text: 'Tertiary',
    state: ButtonState.tertiary,
    size: ButtonSize.medium,
  );
}

@UseCase(name: 'Disabled Medium', type: OutlineButton)
Widget disabledMediumOutlineButton(BuildContext context) {
  return OutlineButton(
    text: 'Disabled',
    state: ButtonState.disabled,
    size: ButtonSize.medium,
  );
}
