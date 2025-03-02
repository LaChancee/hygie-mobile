class UserProfile {
  List<String> addictions = [];
  String consumptionFrequency = "";
  int cigarettesPerDay = 0;
  double monthlyBudget = 0.0;
  String gender = "";
  String email = "";
  String password = "";

  UserProfile({
    this.addictions = const [],
    this.consumptionFrequency = "",
    this.cigarettesPerDay = 0,
    this.monthlyBudget = 0.0,
    this.gender = "",
    this.email = "",
    this.password = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'addictions': addictions,
      'consumptionFrequency': consumptionFrequency,
      'cigarettesPerDay': cigarettesPerDay,
      'monthlyBudget': monthlyBudget,
      'gender': gender,
      'email': email,
    };
  }
}
