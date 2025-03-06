import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/navigation/custom_navbar.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Primary', type: CustomNavbar)
Widget customNavbar(BuildContext context) {
  return CustomNavbar();
}
