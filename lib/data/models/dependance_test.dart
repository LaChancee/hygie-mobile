import 'package:cloud_firestore/cloud_firestore.dart';

class DependanceTest {
  final String id;
  final String userId;
  final String dependanceType; // 'tabac' ou 'alcool'
  final int score; // Score calculé
  final String level; // Niveau de dépendance (Faible, Modérée, Élevée)
  final DateTime createdAt; // Utiliser createdAt partout
  final Map<int, int> responses; // Réponses aux questions

  DependanceTest({
    required this.id,
    required this.userId,
    required this.dependanceType,
    required this.score,
    required this.level,
    required this.createdAt,
    required this.responses,
  });

  // Convertir en Map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'dependanceType': dependanceType,
      'score': score,
      'level': level,
      'createdAt': Timestamp.fromDate(createdAt),
      'responses': responses,
    };
  }

  // Créer depuis un Map de Firestore
  factory DependanceTest.fromMap(Map<String, dynamic> map) {
    return DependanceTest(
      id: map['id'],
      userId: map['userId'],
      dependanceType: map['dependanceType'],
      score: map['score'],
      level: map['level'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      responses: Map<int, int>.from(map['responses']),
    );
  }

  // Calculer le score en fonction des réponses
  static int calculateScore(Map<int, int> responses, String dependanceType) {
    // Implémentation simple: chaque réponse contribue jusqu'à 20 points
    int totalPoints = 0;

    // Si pas de réponses, retourner 0
    if (responses.isEmpty) return 0;

    // Pour un test de 6 questions, max 100 points
    int maxPoints = 100;

    // Points selon le type de dépendance et la question
    if (dependanceType == 'tabac') {
      // Questions tabac: chaque réponse a une valeur différente
      if (responses.containsKey(1))
        totalPoints += (3 - responses[1]!) * 10; // Plus tôt = plus de points
      if (responses.containsKey(2))
        totalPoints += responses[2]! == 0 ? 15 : 0; // Oui = 15 points
      if (responses.containsKey(3))
        totalPoints += responses[3]! == 0 ? 15 : 5; // Première = 15, autre = 5
      if (responses.containsKey(4))
        totalPoints += responses[4]! * 5; // Plus de cig = plus de points
      if (responses.containsKey(5))
        totalPoints += responses[5]! == 0 ? 10 : 0; // Oui = 10 points
      if (responses.containsKey(6))
        totalPoints += responses[6]! == 0 ? 10 : 0; // Oui = 10 points
    } else {
      // alcool
      // Questions alcool: structure similaire
      if (responses.containsKey(1))
        totalPoints += responses[1]! * 8; // Plus fréquent = plus de points
      if (responses.containsKey(2))
        totalPoints += responses[2]! == 0 ? 15 : 0; // Oui = 15 points
      if (responses.containsKey(3))
        totalPoints += responses[3]! == 0 ? 15 : 5; // Première = 15, autre = 5
      if (responses.containsKey(4))
        totalPoints += responses[4]! * 5; // Plus de verres = plus de points
      if (responses.containsKey(5))
        totalPoints += responses[5]! == 0 ? 10 : 0; // Oui = 10 points
      if (responses.containsKey(6))
        totalPoints += responses[6]! == 0 ? 10 : 0; // Oui = 10 points
    }

    // Limiter à 100 points maximum
    return totalPoints > 100 ? 100 : totalPoints;
  }

  // Convertir Firestore document en objet DependanceTest
  factory DependanceTest.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Convertir les réponses de Map<String, dynamic> à Map<int, int>
    Map<int, int> responses = {};
    if (data['responses'] != null) {
      Map<String, dynamic> responsesData =
          data['responses'] as Map<String, dynamic>;
      responsesData.forEach((key, value) {
        responses[int.parse(key)] =
            value is int ? value : int.parse(value.toString());
      });
    }

    return DependanceTest(
      id: doc.id,
      userId: data['userId'] ?? 'anonymous',
      dependanceType: data['dependanceType'] ?? '',
      score: data['score'] is int
          ? data['score']
          : int.parse(data['score'].toString()),
      level: data['level'] ?? 'Non déterminé',
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      responses: responses,
    );
  }

  // Convertir objet DependanceTest en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    // Convertir les réponses de Map<int, int> à Map<String, dynamic>
    Map<String, dynamic> responsesData = {};
    responses.forEach((key, value) {
      responsesData[key.toString()] = value;
    });

    return {
      'id': id,
      'userId': userId,
      'dependanceType': dependanceType,
      'score': score,
      'level': level,
      'responses': responsesData,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
