import 'package:hygie_mobile/models/user_profile.dart';

class UserProfileService {
  static final UserProfileService _instance = UserProfileService._internal();

  factory UserProfileService() {
    return _instance;
  }

  UserProfileService._internal();

  // Instance unique du profil utilisateur
  final UserProfile _userProfile = UserProfile();

  // Getters pour accéder aux données du profil
  UserProfile get userProfile => _userProfile;

  // Méthodes pour mettre à jour les données du profil
  void setAddictions(List<String> addictions) {
    _userProfile.addictions = addictions;
  }

  void setConsumptionFrequency(String frequency) {
    _userProfile.consumptionFrequency = frequency;
  }

  void setCigarettesPerDay(int count) {
    _userProfile.cigarettesPerDay = count;
  }

  void setMonthlyBudget(double budget) {
    _userProfile.monthlyBudget = budget;
  }

  void setGender(String gender) {
    _userProfile.gender = gender;
  }

  void setEmailAndPassword(String email, String password) {
    _userProfile.email = email;
    _userProfile.password = password;
  }

  // Méthode pour réinitialiser le profil
  void resetProfile() {
    _userProfile.addictions = [];
    _userProfile.consumptionFrequency = "";
    _userProfile.cigarettesPerDay = 0;
    _userProfile.monthlyBudget = 0.0;
    _userProfile.gender = "";
    _userProfile.email = "";
    _userProfile.password = "";
  }
}
