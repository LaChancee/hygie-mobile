import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hygie_mobile/models/user_profile.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Méthode pour créer un compte utilisateur avec les données du profil
  Future<UserCredential> createUserWithProfile(UserProfile profile) async {
    try {
      // Créer l'utilisateur dans Firebase Auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: profile.email,
        password: profile.password,
      );

      // Ajouter les données du profil dans Firestore
      await _firestore.collection('profil').doc(userCredential.user?.uid).set({
        'id': userCredential.user?.uid,
        'name': "",
        'image': "",
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'stripeCustomerId': "",
        'plan': "",
        'passwordHash': "",
        'accounts': [],
        'feedbacks': [],
        'consommation': {},
        'points': 0,
        // Ajouter les données du questionnaire
        'addictions': profile.addictions,
        'consumptionFrequency': profile.consumptionFrequency,
        'cigarettesPerDay': profile.cigarettesPerDay,
        'monthlyBudget': profile.monthlyBudget,
        'gender': profile.gender,
        'email': profile.email,
      });

      return userCredential;
    } catch (e) {
      rethrow; // Relancer l'exception pour la gérer dans l'UI
    }
  }

  // Méthode pour se connecter
  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Méthode pour se déconnecter
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Vérifier si l'utilisateur est connecté
  User? get currentUser => _auth.currentUser;
}
