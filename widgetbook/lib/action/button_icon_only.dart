import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/action/onlyIconButton/button_icon_only.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';


@UseCase(name: 'Primary Icon Button', type: IconButtonCustom)
Widget primaryButtonWithIcon(BuildContext context) {
  return IconButtonCustom(
    state: IconButtonState.primary,
    icon: const Icon(Icons.star, color: Colors.black),
  );
}


@UseCase(name: 'Secondary Icon Button', type: IconButtonCustom)
Widget secondaryButtonWithIcon(BuildContext context) {
  return IconButtonCustom(
    state: IconButtonState.secondary,
    icon: const Icon(Icons.star, color: Colors.black),
  );
}
@UseCase(name: 'Tertiary Icon Button', type: IconButtonCustom)
Widget tertiaryButtonWithIcon(BuildContext context) {
  return IconButtonCustom(
    state: IconButtonState.tertiary,
    icon: const Icon(Icons.star, color: Colors.black),
  );
}



