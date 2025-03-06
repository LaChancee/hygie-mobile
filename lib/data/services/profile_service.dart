import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection Firestore pour les profils
  CollectionReference get _profilesCollection =>
      _firestore.collection('profil');

  // Obtenir l'ID de l'utilisateur actuel
  String get userId => _auth.currentUser?.uid ?? 'anonymous';

  // Obtenir le profil utilisateur
  Future<Map<String, dynamic>?> getProfile() async {
    try {
      DocumentSnapshot profileDoc = await _profilesCollection.doc(userId).get();
      if (profileDoc.exists) {
        return profileDoc.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      print('Erreur lors de la récupération du profil: $e');
      return null;
    }
  }

  // Obtenir les points du profil
  Future<int> getPoints() async {
    try {
      DocumentSnapshot profileDoc = await _profilesCollection.doc(userId).get();
      if (profileDoc.exists) {
        var profileData = profileDoc.data() as Map<String, dynamic>;
        return profileData['points'] ?? 0;
      }
      return 0;
    } catch (e) {
      print('Erreur lors de la récupération des points: $e');
      return 0;
    }
  }

  // Ajouter des points au profil
  Future<bool> addPoints(int amount) async {
    try {
      print('Début de l\'ajout de $amount points au profil. UserId: $userId');

      if (userId == 'anonymous') {
        print('Utilisateur anonyme, impossible d\'ajouter des points');
        return false;
      }

      // Récupérer le document profil
      DocumentReference profileRef = _profilesCollection.doc(userId);
      DocumentSnapshot profileDoc = await profileRef.get();

      print('Document profil existe: ${profileDoc.exists}');

      if (profileDoc.exists) {
        // Mise à jour des points existants
        var profileData = profileDoc.data() as Map<String, dynamic>?;
        int currentPoints = profileData?['points'] ?? 0;

        print(
            'Points actuels: $currentPoints, Nouveaux points: ${currentPoints + amount}');

        await profileRef.update({
          'points': currentPoints + amount,
          'lastPointsUpdate': FieldValue.serverTimestamp(),
        });
      } else {
        // Création d'un nouveau profil
        print('Création d\'un nouveau profil avec $amount points');

        await profileRef.set({
          'userId': userId,
          'points': amount,
          'createdAt': FieldValue.serverTimestamp(),
          'lastPointsUpdate': FieldValue.serverTimestamp(),
        });
      }

      return true;
    } catch (e) {
      print('Erreur lors de l\'ajout de points au profil: $e');
      return false;
    }
  }

  // Mettre à jour le profil utilisateur
  Future<bool> updateProfile(Map<String, dynamic> data) async {
    try {
      await _profilesCollection.doc(userId).set(
            data,
            SetOptions(merge: true),
          );
      return true;
    } catch (e) {
      print('Erreur lors de la mise à jour du profil: $e');
      return false;
    }
  }
}
