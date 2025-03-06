import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/dependance_test.dart';
import 'hycoins_service.dart';

class DependanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final HyCoinsService _hyCoinsService = HyCoinsService();

  // Collection Firestore pour les tests de dépendance
  CollectionReference get _testsCollection =>
      _firestore.collection('dependance_tests');

  // Obtenir l'ID de l'utilisateur actuel
  String get _userId => _auth.currentUser?.uid ?? 'anonymous';

  // Sauvegarder un test de dépendance
  Future<DependanceTest> saveTest({
    required String dependanceType,
    required Map<int, int> responses,
  }) async {
    try {
      // Calculer le score
      int score = DependanceTest.calculateScore(responses, dependanceType);
      String level = _getDependanceLevel(score);

      // Créer le document pour Firestore - conversion des clés int en String
      final testData = {
        'userId': _userId,
        'dependanceType': dependanceType,
        'responses':
            responses.map((key, value) => MapEntry(key.toString(), value)),
        'score': score,
        'level': level, // Ajout du niveau comme String
        'createdAt': Timestamp.now(),
      };

      // Ajouter le document à Firestore
      DocumentReference docRef = await _testsCollection.add(testData);

      // Récupérer le document ajouté pour obtenir l'ID
      DocumentSnapshot doc = await docRef.get();

      // Attribuer des HyCoins pour la complétion du test
      await _awardHyCoinsForTest(dependanceType);

      // Retourner l'objet DependanceTest
      return DependanceTest(
        id: doc.id,
        userId: _userId,
        dependanceType: dependanceType,
        responses: responses,
        score: score,
        level: level,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      print('Erreur lors de l\'enregistrement du test: $e');
      // En cas d'erreur, retourner un objet avec un score par défaut
      return DependanceTest(
        id: 'error',
        userId: _userId,
        dependanceType: dependanceType,
        responses: responses,
        score: 50, // Score par défaut en cas d'erreur
        level: "Modérée",
        createdAt: DateTime.now(),
      );
    }
  }

  // Attribuer des HyCoins pour la complétion d'un test
  Future<void> _awardHyCoinsForTest(String dependanceType) async {
    try {
      // Vérifier si l'utilisateur a déjà fait ce test aujourd'hui
      bool isFirstTestToday = await _isFirstTestOfTypeToday(dependanceType);

      // Déterminer le montant à attribuer
      int coinsAmount = 375; // Le montant affiché dans l'interface

      // Si ce n'est pas le premier test du jour, réduire la récompense
      if (!isFirstTestToday) {
        coinsAmount = 100; // Récompense réduite pour les tests répétés
      }

      // Attribuer les HyCoins
      await _hyCoinsService.addCoins(
        coinsAmount,
        reason: 'Test de dépendance au ${dependanceType}',
      );
    } catch (e) {
      print('Erreur lors de l\'attribution des HyCoins: $e');
    }
  }

  // Vérifier si c'est le premier test d'un type donné fait aujourd'hui
  Future<bool> _isFirstTestOfTypeToday(String dependanceType) async {
    try {
      // Définir le début de la journée
      DateTime now = DateTime.now();
      DateTime startOfDay = DateTime(now.year, now.month, now.day);
      Timestamp startTimestamp = Timestamp.fromDate(startOfDay);

      // Rechercher des tests du même type faits aujourd'hui
      QuerySnapshot testsToday = await _testsCollection
          .where('userId', isEqualTo: _userId)
          .where('dependanceType', isEqualTo: dependanceType)
          .where('createdAt', isGreaterThanOrEqualTo: startTimestamp)
          .get();

      // S'il n'y a pas de test ou seulement celui qu'on vient de créer, c'est le premier
      return testsToday.docs.length <= 1;
    } catch (e) {
      print('Erreur lors de la vérification des tests précédents: $e');
      return true; // En cas d'erreur, supposer que c'est le premier test
    }
  }

  // Récupérer le dernier test de dépendance de l'utilisateur
  Future<DependanceTest?> getLastTest() async {
    try {
      QuerySnapshot querySnapshot = await _testsCollection
          .where('userId', isEqualTo: _userId)
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return DependanceTest.fromFirestore(querySnapshot.docs.first);
      }
      return null;
    } catch (e) {
      print('Erreur lors de la récupération du dernier test: $e');
      return null;
    }
  }

  // Récupérer tous les tests de dépendance de l'utilisateur
  Future<List<DependanceTest>> getAllTests() async {
    try {
      QuerySnapshot querySnapshot = await _testsCollection
          .where('userId', isEqualTo: _userId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => DependanceTest.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Erreur lors de la récupération des tests: $e');
      return [];
    }
  }

  String _getDependanceLevel(int score) {
    if (score < 30) return "Faible";
    if (score < 60) return "Modérée";
    return "Élevée";
  }
}
