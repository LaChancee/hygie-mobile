# Cahier de Tests - Module Programme de l'Application Hygie Mobile

## Introduction

Ce cahier de tests définit les procédures de test pour le module Programme de l'application Hygie Mobile. Il inclut les tests unitaires, d'intégration et fonctionnels nécessaires pour assurer la qualité et la fiabilité des fonctionnalités liées aux programmes de santé.

## Équipe et Responsabilités

- **Développeurs** : Implémentation des fonctionnalités et tests unitaires
- **Testeurs** : Exécution des tests et documentation des résultats
- **Chef de Projet** : Validation finale des tests

## Environnement de Test

- **Plateforme** : Flutter
- **Versions** : Flutter 3.16+, Dart 3.0+
- **Appareils de Test** :
  - Android (Pixel 4, Samsung Galaxy S21)
  - iOS (iPhone 12, iPhone 14)
- **Outils de Test** : Flutter Test, Firebase Test Lab

## Tests Unitaires

### 1. Test de la Section Programme (`ProgramSection`)

| ID   | Description                                                 | Résultat Attendu                                                                             | Priorité |
| ---- | ----------------------------------------------------------- | -------------------------------------------------------------------------------------------- | -------- |
| U-01 | Vérifier que `ProgramSection` affiche 3 cartes de programme | 3 cartes de programme sont rendues correctement                                              | Haute    |
| U-02 | Vérifier que les titres des programmes sont corrects        | Les programmes "Sevrage tabagique", "Gestion du stress" et "Activité physique" sont affichés | Haute    |
| U-03 | Vérifier que les indicateurs de progression sont présents   | Tous les programmes ont un indicateur de progression                                         | Moyenne  |
| U-04 | Vérifier que les valeurs de progression sont correctes      | Les valeurs 0.3, 0.5, 0.7 sont appliquées respectivement                                     | Moyenne  |
| U-05 | Vérifier que les jours restants sont affichés               | "21 jours", "15 jours", "10 jours" sont affichés                                             | Moyenne  |

### 2. Test de la Page de Programme Unique (`ModaleProgram`)

| ID   | Description                                           | Résultat Attendu                                                           | Priorité |
| ---- | ----------------------------------------------------- | -------------------------------------------------------------------------- | -------- |
| U-06 | Vérifier que l'en-tête de `ModaleProgram` est correct | Affiche "Programme de sevrage tabagique" et "Arrêt progressif en 30 jours" | Haute    |
| U-07 | Vérifier que la barre de progression est affichée     | Une barre de progression avec dégradé est visible                          | Moyenne  |
| U-08 | Vérifier que la description du programme est affichée | La section "Description du programme" est présente                         | Haute    |
| U-09 | Vérifier que les étapes du programme sont affichées   | Les 4 étapes (Préparation, Réduction, Arrêt, Maintien) sont affichées      | Haute    |
| U-10 | Vérifier que les boutons d'action sont présents       | Les boutons "Retour" et "Commencer" sont affichés                          | Haute    |

## Tests d'Intégration

### 1. Navigation et Interaction

| ID   | Description                                                 | Résultat Attendu                                        | Priorité |
| ---- | ----------------------------------------------------------- | ------------------------------------------------------- | -------- |
| I-01 | Navigation depuis la page Journal vers l'onglet Programme   | L'onglet Programme s'affiche avec 3 programmes          | Haute    |
| I-02 | Flux de navigation de `ProgramSection` vers `ModaleProgram` | Cliquer sur une carte ouvre la modale de détail         | Haute    |
| I-03 | Bouton "Retour" dans `ModaleProgram`                        | Le bouton ferme la modale et revient à `ProgramSection` | Haute    |
| I-04 | Bouton "Commencer" dans `ModaleProgram`                     | Le bouton ferme la modale et enregistre l'action        | Moyenne  |

## Tests Fonctionnels

### 1. Affichage et Interaction avec les Programmes

| ID   | Description                              | Procédure                                                                                          | Résultat Attendu                                                                         | Priorité |
| ---- | ---------------------------------------- | -------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- | -------- |
| F-01 | Affichage des programmes                 | 1. Ouvrir l'application<br>2. Naviguer vers l'onglet Journal<br>3. Sélectionner l'onglet Programme | Les programmes sont affichés avec leur titre, description, progression et jours restants | Haute    |
| F-02 | Ouverture des détails d'un programme     | 1. Depuis l'onglet Programme<br>2. Toucher une carte de programme                                  | La modale s'ouvre avec les détails du programme sélectionné                              | Haute    |
| F-03 | Navigation dans les détails du programme | 1. Ouvrir une modale de programme<br>2. Faire défiler le contenu                                   | Le contenu défile correctement et tous les éléments sont visibles                        | Moyenne  |
| F-04 | Fermeture de la modale de détails        | 1. Ouvrir une modale de programme<br>2. Appuyer sur "Retour"                                       | La modale se ferme et revient à la liste des programmes                                  | Haute    |
| F-05 | Démarrer un programme                    | 1. Ouvrir une modale de programme<br>2. Appuyer sur "Commencer"                                    | La modale se ferme et un message de confirmation apparaît                                | Haute    |

### 2. Responsive Design

| ID   | Description                | Procédure                                                                                           | Résultat Attendu                                          | Priorité |
| ---- | -------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------- | -------- |
| F-06 | Responsive sur petit écran | 1. Ouvrir l'application sur un appareil avec petit écran<br>2. Naviguer vers les programmes         | L'interface s'adapte correctement au petit écran          | Moyenne  |
| F-07 | Responsive sur grand écran | 1. Ouvrir l'application sur un appareil avec grand écran<br>2. Naviguer vers les programmes         | L'interface s'adapte correctement au grand écran          | Moyenne  |
| F-08 | Orientation paysage        | 1. Ouvrir l'application<br>2. Pivoter l'appareil en mode paysage<br>3. Naviguer vers les programmes | L'interface s'adapte correctement à l'orientation paysage | Basse    |

## Cas de Tests Exploratoires

| ID   | Domaine                  | Objectif                                | Focus                                  |
| ---- | ------------------------ | --------------------------------------- | -------------------------------------- |
| E-01 | Interactions utilisateur | Vérifier les interactions non standards | Gestes de balayage, appuis longs, zoom |
| E-02 | États des programmes     | Tester différents états de progression  | 0%, 50%, 100% de progression           |
| E-03 | Conditions limites       | Tester les comportements aux limites    | Très long titre, 0 jour restant, etc.  |

## Procédure d'Exécution des Tests

1. **Tests Unitaires**

   ```bash
   flutter test test/programme/programme_test.dart
   flutter test test/programme/single_programme_test.dart
   ```

2. **Tests d'Intégration**

   ```bash
   flutter test test/integration/programme_integration_test.dart
   ```

3. **Tests Fonctionnels**
   - Exécution manuelle selon les procédures détaillées
   - Documentation des résultats dans le tableau ci-dessous

## Résultats des Tests

| ID   | Statut | Date | Testeur | Commentaires |
| ---- | ------ | ---- | ------- | ------------ |
| U-01 | ⬜     |      |         |              |
| U-02 | ⬜     |      |         |              |
| U-03 | ⬜     |      |         |              |
| ...  | ...    | ...  | ...     | ...          |

## Historique des Révisions

| Version | Date       | Auteur | Description des Modifications      |
| ------- | ---------- | ------ | ---------------------------------- |
| 1.0     | 07/06/2024 |        | Version initiale du cahier de test |

## Annexes

### Dépendances et Prérequis

- Flutter SDK installé
- Clé Firebase configurée (pour les tests avec Firebase)
- Appareils de test ou émulateurs configurés

### Configuration des Tests

Assurez-vous que le fichier `pubspec.yaml` contient les dépendances suivantes pour les tests :

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.0
  integration_test:
    sdk: flutter
```

### Glossaire

- **Programme** : Un plan structuré d'activités pour aider l'utilisateur à atteindre un objectif de santé
- **Progression** : Indicateur visuel du pourcentage d'achèvement d'un programme
- **ModaleProgram** : L'interface détaillée d'un programme spécifique
- **ProgramSection** : Le composant qui affiche la liste des programmes disponibles
