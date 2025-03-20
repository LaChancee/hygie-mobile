import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HyCoinsProvider extends ChangeNotifier {
  int _points = 0;
  bool _isLoading = false;
  String? _error;

  int get points => _points;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadUserPoints() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('profil')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          _points = userDoc.data()?['points'] as int? ?? 0;
        }
      }
    } catch (e) {
      _error = 'Erreur lors de la récupération des points: $e';
      print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePoints(int newPoints) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('profil')
            .doc(user.uid)
            .update({
          'points': newPoints,
        });
        _points = newPoints;
      }
    } catch (e) {
      _error = 'Erreur lors de la mise à jour des points: $e';
      print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Pour ajouter des points (comme lors de l'accomplissement d'objectifs)
  Future<void> addPoints(int pointsToAdd) async {
    await updatePoints(_points + pointsToAdd);
  }

  // Pour soustraire des points (comme lors de l'achat de récompenses)
  Future<void> subtractPoints(int pointsToSubtract) async {
    await updatePoints(_points - pointsToSubtract);
  }
}
