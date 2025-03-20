import 'package:flutter/material.dart';
import 'package:hygie_mobile/services/abstinence_calculator.dart';

class Cards extends StatefulWidget {
  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  int _daysWithoutTobacco = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDaysWithoutTobacco();
  }

  Future<void> _loadDaysWithoutTobacco() async {
    try {
      final days = await AbstinenceCalculator.getDaysWithoutTobacco();
      setState(() {
        _daysWithoutTobacco = days;
        _isLoading = false;
      });
    } catch (e) {
      print('Erreur lors du chargement des jours sans tabac: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFF1991FF), Color(0xFF044BD9)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 8,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Jours sans tabac',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: ShapeDecoration(
                  color: Color(0x19FFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.smoke_free,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Tabac',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Row(
                  children: [
                    Text(
                      _daysWithoutTobacco.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _daysWithoutTobacco <= 1 ? 'jour' : 'jours',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 8),
          Text(
            _getMotivationalMessage(_daysWithoutTobacco),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  String _getMotivationalMessage(int days) {
    if (days == 0) {
      return "C'est le moment de commencer votre parcours sans tabac !";
    } else if (days <= 3) {
      return "Les premières 72 heures sont cruciales. Continuez, vous êtes sur la bonne voie !";
    } else if (days <= 7) {
      return "Après une semaine, votre goût et odorat s'améliorent !";
    } else if (days <= 14) {
      return "Votre circulation sanguine s'améliore chaque jour sans tabac.";
    } else if (days <= 30) {
      return "Presque un mois ! Votre peau récupère et votre respiration s'améliore.";
    } else if (days <= 90) {
      return "Vos poumons commencent à se nettoyer. Continuez ainsi !";
    } else if (days <= 180) {
      return "Vous êtes sur la voie de la liberté ! Votre risque de maladies cardiaques diminue.";
    } else {
      return "Félicitations ! Vous avez considérablement réduit vos risques de cancer du poumon.";
    }
  }
}
