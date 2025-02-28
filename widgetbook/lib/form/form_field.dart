import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/inputs/custom_input_field.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: CustomInputField)
Widget defaultInputField(BuildContext context) {
  return CustomInputField(
    label: 'Nom',
    isRequired: false,
    hintText: 'Entrez votre nom',
    helpText: 'Votre prénom et nom complet.',
  );
}

@UseCase(name: 'Required Field', type: CustomInputField)
Widget requiredInputField(BuildContext context) {
  return CustomInputField(
    label: 'Email',
    isRequired: true,
    hintText: 'Entrez votre email',
    helpText: 'Veuillez entrer un email valide.',
  );
}

@UseCase(name: 'With Initial Value', type: CustomInputField)
Widget inputFieldWithInitialValue(BuildContext context) {
  return CustomInputField(
    label: 'Montant',
    isRequired: true,
    initialValue: '100',
    hintText: 'Saisissez un montant',
    helpText: 'Montant en euros (€).',
  );
}

@UseCase(name: 'Error State', type: CustomInputField)
Widget inputFieldWithError(BuildContext context) {
  return CustomInputField(
    label: 'Téléphone',
    isRequired: true,
    hintText: 'Entrez votre numéro de téléphone',
    helpText: 'Le numéro doit être au format international.',
    onChanged: (value) {
      // Simule un état d'erreur si la valeur est incorrecte
      if (value.length < 10) {
        print('Erreur : Numéro trop court');
      }
    },
  );
}
