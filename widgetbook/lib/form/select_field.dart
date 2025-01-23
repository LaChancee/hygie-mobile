import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:hygie_mobile/commons/inputs/select_field.dart';

@UseCase(name: 'Default', type: PropertyButton)
Widget defaultPropertyButton(BuildContext context) {
  return PropertyButton(
    text: 'Une fois par semaine',
    isSelected: false,
  );
}

@UseCase(name: 'Selected', type: PropertyButton)
Widget selectedPropertyButton(BuildContext context) {
  return PropertyButton(
    text: 'Une fois par semaine',
    isSelected: true,
  );
}
