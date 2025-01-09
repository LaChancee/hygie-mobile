import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/action/button_state.dart';
import 'package:hygie_mobile/commons/action/onlyIconButton/button.';


@UseCase(name: 'Primary Icon Button', type: IconButtonCustom)
Widget tertiaryButtonWithIcon(BuildContext context) {
  return ButtonWithIcon(
    text: 'Tertiary',
    state: ButtonState.tertiary,
    icon: const Icon(Icons.star, color: Colors.black),
    iconPosition: IconPosition.right,
  );
}

