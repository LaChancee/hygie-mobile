import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_service.dart';

class HyCoinsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ProfileService _profileService = ProfileService();

  // Collection Firestore pour les utilisateurs
  CollectionReference get _usersCollection => _firestore.collection('users');

  // Obtenir l'ID de l'utilisateur actuel
  String get userId => _auth.currentUser?.uid ?? 'anonymous';

  // Obtenir le solde actuel de HyCoins
  Future<int> getBalance() async {
    try {
      DocumentSnapshot userDoc = await _usersCollection.doc(userId).get();
      if (userDoc.exists) {
        var userData = userDoc.data() as Map<String, dynamic>;
        return userData['hycoins'] ?? 0;
      }
      return 0;
    } catch (e) {
      print('Erreur lors de la récupération du solde HyCoins: $e');
      return 0;
    }
  }

  // Ajouter des HyCoins au solde de l'utilisateur
  Future<bool> addCoins(int amount, {String reason = ''}) async {
    try {
      print(
          'Début de l\'ajout de $amount HyCoins. UserId: $userId, Raison: $reason');

      if (userId == 'anonymous') {
        print('Utilisateur anonyme, impossible d\'ajouter des HyCoins');
        return false;
      }

      // Récupérer le document utilisateur
      DocumentReference userRef = _usersCollection.doc(userId);
      DocumentSnapshot userDoc = await userRef.get();

      print('Document utilisateur existe: ${userDoc.exists}');

      if (userDoc.exists) {
        // Mise à jour du solde existant
        var userData = userDoc.data() as Map<String, dynamic>?;
        int currentBalance = userData?['hycoins'] ?? 0;

        print(
            'Solde actuel: $currentBalance, Nouveau solde: ${currentBalance + amount}');

        await userRef.update({
          'hycoins': currentBalance + amount,
          'lastCoinUpdate': FieldValue.serverTimestamp(),
        });
      } else {
        // Création d'un nouveau document utilisateur
        print(
            'Création d\'un nouveau document utilisateur avec $amount HyCoins');

        await userRef.set({
          'userId': userId,
          'hycoins': amount,
          'createdAt': FieldValue.serverTimestamp(),
          'lastCoinUpdate': FieldValue.serverTimestamp(),
        });
      }

      // Enregistrer la transaction
      await _recordTransaction(amount, reason);

      // Ajouter les points au profil utilisateur également
      bool profileUpdated = await _profileService.addPoints(amount);
      print('Profil mis à jour: $profileUpdated');

      return true;
    } catch (e) {
      print('Erreur lors de l\'ajout de HyCoins: $e');
      return false;
    }
  }

  // Enregistrer une transaction de HyCoins
  Future<void> _recordTransaction(int amount, String reason) async {
    try {
      await _firestore.collection('hycoins_transactions').add({
        'userId': userId,
        'amount': amount,
        'reason': reason,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Erreur lors de l\'enregistrement de la transaction: $e');
    }
  }

  // Récupérer l'historique des transactions
  Future<List<Map<String, dynamic>>> getTransactionHistory() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('hycoins_transactions')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'amount': data['amount'],
          'reason': data['reason'],
          'timestamp': (data['timestamp'] as Timestamp).toDate(),
        };
      }).toList();
    } catch (e) {
      print(
          'Erreur lors de la récupération de l\'historique des transactions: $e');
      return [];
    }
  }

  // Obtenir à la fois les HyCoins et les points du profil
  Future<Map<String, int>> getBalanceAndPoints() async {
    try {
      final hycoins = await getBalance();
      final points = await _profileService.getPoints();

      return {
        'hycoins': hycoins,
        'points': points,
      };
    } catch (e) {
      print('Erreur lors de la récupération des soldes: $e');
      return {
        'hycoins': 0,
        'points': 0,
      };
    }
  }
}
