import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AbstinenceCalculator {
  static Future<int> getDaysWithoutTobacco() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return 0;

      // Récupérer la dernière consommation de tabac
      final lastConsumptionSnapshot = await FirebaseFirestore.instance
          .collection('consommations')
          .where('userId', isEqualTo: userId)
          .where('type', isEqualTo: 'Tabac')
          .orderBy('date', descending: true)
          .limit(1)
          .get();

      // Récupérer la date d'inscription de l'utilisateur
      final userProfile = await FirebaseFirestore.instance
          .collection('profil')
          .doc(userId)
          .get();

      DateTime startDate;

      // Si l'utilisateur a déjà consommé du tabac, utiliser la date de la dernière consommation
      if (lastConsumptionSnapshot.docs.isNotEmpty) {
        final lastConsumption = lastConsumptionSnapshot.docs.first.data();
        startDate = DateTime.parse(lastConsumption['date']).toLocal();
      }
      // Sinon, utiliser la date d'inscription
      else if (userProfile.exists &&
          userProfile.data()?.containsKey('createdAt')) {
        final createdAt = userProfile.data()?['createdAt'];
        if (createdAt is Timestamp) {
          startDate = createdAt.toDate();
        } else if (createdAt is String) {
          startDate = DateTime.parse(createdAt);
        } else {
          // Si la date d'inscription n'est pas disponible, utiliser la date actuelle
          return 0;
        }
      } else {
        // Si aucune donnée n'est disponible, retourner 0
        return 0;
      }

      // Calculer la différence en jours entre aujourd'hui et la date de départ
      final now = DateTime.now();
      final difference = now.difference(startDate);
      return difference.inDays;
    } catch (e) {
      print('Erreur lors du calcul des jours sans tabac: $e');
      return 0;
    }
  }
}
