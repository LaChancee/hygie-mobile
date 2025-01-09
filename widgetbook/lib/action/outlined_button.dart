import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/action/button_state.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:hygie_mobile/commons/action/withoutIcon//button.dart';
import 'package:hygie_mobile/commons/action/withoutIcon/buttonOutline.dart';


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

@UseCase(name: 'Outlined Secondary', type: OutlineButton)
Widget outlineSecondaryButton(BuildContext context) {
  return OutlineButton(
      text: 'Secondary',
      state: ButtonState.secondary
  );
}
@UseCase(name: 'Outlined Secondary Pressed', type: OutlineButton)
Widget outlinePressedSecondaryButton(BuildContext context) {
  return OutlineButton(
      text: 'Pressed',
      state: ButtonState.secondaryPressed
  );
}

@UseCase(name: 'Outlined Tertiary', type: OutlineButton)
Widget outlineTertiaryButton(BuildContext context) {
  return OutlineButton(
      text: 'Tertiary',
      state: ButtonState.tertiary
  );
}
@UseCase(name: 'Outlined Tertiary Pressed', type: OutlineButton)
Widget outlinePressedTertiaryButton(BuildContext context) {
  return OutlineButton(
      text: 'Pressed',
      state: ButtonState.tertiaryPressed
  );
}
