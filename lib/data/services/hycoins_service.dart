import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HyCoinsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      // Récupérer le document utilisateur
      DocumentReference userRef = _usersCollection.doc(userId);
      DocumentSnapshot userDoc = await userRef.get();

      if (userDoc.exists) {
        // Mise à jour du solde existant
        var userData = userDoc.data() as Map<String, dynamic>;
        int currentBalance = userData['hycoins'] ?? 0;
        await userRef.update({
          'hycoins': currentBalance + amount,
          'lastCoinUpdate': FieldValue.serverTimestamp(),
        });
      } else {
        // Création d'un nouveau document utilisateur
        await userRef.set({
          'userId': userId,
          'hycoins': amount,
          'createdAt': FieldValue.serverTimestamp(),
          'lastCoinUpdate': FieldValue.serverTimestamp(),
        });
      }

      // Enregistrer la transaction
      await _recordTransaction(amount, reason);

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
}
