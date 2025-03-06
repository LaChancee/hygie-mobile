import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/dependance_test.dart';
import '../services/dependance_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DependanceTestProvider extends ChangeNotifier {
  final DependanceService _dependanceService = DependanceService();

  String _dependanceType = ''; // 'tabac' ou 'alcool'
  final Map<int, int> _responses =
      {}; // Question number -> selected response index
  DependanceTest? _lastTest;
  bool _isLoading = false;

  // Getters
  String get dependanceType => _dependanceType;
  Map<int, int> get responses => _responses;
  DependanceTest? get lastTest => _lastTest;
  bool get isLoading => _isLoading;

  // Initialiser le test avec le type de dépendance
  void initTest(String type) {
    _dependanceType = type;
    _responses.clear();
    notifyListeners();
  }

  // Enregistrer une réponse
  void saveResponse(int questionNumber, int responseIndex) {
    _responses[questionNumber] = responseIndex;
    notifyListeners();
  }

  // Calculer le score en fonction des réponses
  int calculateScore() {
    if (_responses.isEmpty) return 0;

    // Différents calculs selon le type de dépendance
    if (_dependanceType == 'tabac') {
      return _calculateTabacScore();
    } else {
      return _calculateAlcoolScore();
    }
  }

  // Calcul spécifique pour le tabac
  int _calculateTabacScore() {
    int score = 0;

    // Question 1: Combien de temps après votre réveil fumez-vous votre première cigarette ?
    if (_responses.containsKey(1)) {
      final q1 = _responses[1]!;
      if (q1 == 0)
        score += 30; // Dans les 5 minutes
      else if (q1 == 1)
        score += 20; // Entre 6 et 30 minutes
      else if (q1 == 2)
        score += 10; // Entre 31 et 60 minutes
      else
        score += 5; // Après 60 minutes
    }

    // Question 2: Trouvez-vous difficile de vous abstenir de fumer dans les endroits où c'est interdit ?
    if (_responses.containsKey(2)) {
      final q2 = _responses[2]!;
      if (q2 == 0) score += 15; // Oui
      // Non ajoute 0
    }

    // Question 3: Quelle cigarette trouvez-vous la plus indispensable ?
    if (_responses.containsKey(3)) {
      final q3 = _responses[3]!;
      if (q3 == 0)
        score += 15; // La première de la journée
      else
        score += 5; // Une autre
    }

    // Question 4: Combien de cigarettes fumez-vous par jour ?
    if (_responses.containsKey(4)) {
      final q4 = _responses[4]!;
      if (q4 == 0)
        score += 5; // 10 ou moins
      else if (q4 == 1)
        score += 10; // 11 à 20
      else if (q4 == 2)
        score += 15; // 21 à 30
      else
        score += 20; // 31 ou plus
    }

    // Question 5: Fumez-vous plus fréquemment dans les premières heures après le réveil ?
    if (_responses.containsKey(5)) {
      final q5 = _responses[5]!;
      if (q5 == 0) score += 10; // Oui
      // Non ajoute 0
    }

    // Question 6: Fumez-vous lorsque vous êtes malade ?
    if (_responses.containsKey(6)) {
      final q6 = _responses[6]!;
      if (q6 == 0) score += 10; // Oui
      // Non ajoute 0
    }

    // Normaliser le score sur 100
    // Le score maximum théorique est de 100 (si toutes les réponses donnent le max de points)
    return score;
  }

  // Calcul spécifique pour l'alcool
  int _calculateAlcoolScore() {
    int score = 0;

    // Question 1: À quelle fréquence consommez-vous de l'alcool ?
    if (_responses.containsKey(1)) {
      final q1 = _responses[1]!;
      if (q1 == 0)
        score += 5; // Jamais ou occasionnellement
      else if (q1 == 1)
        score += 15; // 1 à 2 fois par semaine
      else if (q1 == 2)
        score += 25; // 3 à 4 fois par semaine
      else
        score += 35; // Tous les jours
    }

    // Question 2: Avez-vous déjà ressenti le besoin de diminuer votre consommation d'alcool ?
    if (_responses.containsKey(2)) {
      final q2 = _responses[2]!;
      if (q2 == 0) score += 15; // Oui
      // Non ajoute 0
    }

    // Question 3: À quel moment de la journée avez-vous le plus envie de boire ?
    if (_responses.containsKey(3)) {
      final q3 = _responses[3]!;
      if (q3 == 0)
        score += 15; // Le matin
      else
        score += 5; // N'importe quand
    }

    // Question 4: Combien de verres d'alcool consommez-vous par jour ?
    if (_responses.containsKey(4)) {
      final q4 = _responses[4]!;
      if (q4 == 0)
        score += 5; // 1 ou 2
      else if (q4 == 1)
        score += 10; // 3 ou 4
      else if (q4 == 2)
        score += 15; // 5 ou 6
      else
        score += 20; // 7 ou plus
    }

    // Question 5: La consommation d'alcool affecte-t-elle votre vie quotidienne ?
    if (_responses.containsKey(5)) {
      final q5 = _responses[5]!;
      if (q5 == 0) score += 10; // Oui
      // Non ajoute 0
    }

    // Question 6: Consommez-vous de l'alcool même lorsque vous êtes malade ?
    if (_responses.containsKey(6)) {
      final q6 = _responses[6]!;
      if (q6 == 0) score += 15; // Oui
      // Non ajoute 0
    }

    // Normaliser le score sur 100
    return score;
  }

  // Obtenir la description du niveau de dépendance
  String getDependanceLevel() {
    final score = calculateScore();

    if (score < 30) {
      return "Faible";
    } else if (score < 60) {
      return "Modérée";
    } else {
      return "Élevée";
    }
  }

  // Soumettre le test et enregistrer dans Firestore
  Future<DependanceTest> submitTest() async {
    final score = calculateScore();
    final level = getDependanceLevel();

    // Obtenir l'userId actuel
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'anonymous';

    final test = DependanceTest(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      dependanceType: _dependanceType,
      score: score,
      level: level,
      createdAt: DateTime.now(),
      responses: Map.from(_responses),
    );

    try {
      // Enregistrer dans Firestore
      await FirebaseFirestore.instance
          .collection('dependance_tests')
          .doc(test.id)
          .set(test.toMap());
    } catch (e) {
      print("Erreur lors de l'enregistrement du test: $e");
    }

    return test;
  }

  // Réinitialiser le test
  void resetTest() {
    _dependanceType = '';
    _responses.clear();
    notifyListeners();
  }

  // Récupérer l'historique des tests
  Future<List<DependanceTest>> getTestHistory() async {
    _isLoading = true;
    notifyListeners();

    try {
      List<DependanceTest> tests = await _dependanceService.getAllTests();
      _isLoading = false;
      notifyListeners();
      return tests;
    } catch (e) {
      print('Erreur lors de la récupération de l\'historique: $e');
      _isLoading = false;
      notifyListeners();
      return [];
    }
  }
}
