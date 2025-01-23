import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/navigation/topbar/top_bar.dart';
import 'package:hygie_mobile/commons/navigation/topbar/top_bar_no_params.dart';
import 'package:hygie_mobile/commons/navigation/topbar/top_bar_icon_user.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';


@UseCase(name: 'Top Bar', type: CustomTopBar)
Widget customNavbar(BuildContext context) {
  return CustomTopBar(coinCount: '23', coinIcon: Icons.import_contacts, actionIcon: Icons.print,);
}
@UseCase(name: 'Top Bar With Blue Icon', type: TopBarWithBlueIcon)
Widget topBarWithBlueIconUseCase(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        TopBarWithBlueIcon(),
      ],
    ),
  );
}
// Use Case 3: Barre avec seulement une icône à droite
@UseCase(name: 'Top Bar with Right Icon Only', type: TopBarCustomizable)
Widget topBarWithRightIconOnly(BuildContext context) {
  return TopBarCustomizable(
    text: 'Historique',
    leftIcon: Icon(Icons.settings, color: Colors.grey), // Placeholder pour aligner
    rightIcon: const Icon(Icons.settings, color: Colors.grey),
  );
}
