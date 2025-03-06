import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/profil/profil_screen.dart';
import '../../data/services/hycoins_service.dart';
import '../../data/services/profile_service.dart';
import '../../widgets/hycoins_mini.dart';

class TopBar extends StatelessWidget {
  final bool showCagnotte;
  final VoidCallback? onNotificationPressed;
  final String? title;

  const TopBar({
    Key? key,
    this.showCagnotte = true,
    this.onNotificationPressed,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60, // Hauteur fixe pour toutes les TopBar
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Partie gauche: Notification + Cagnotte
          Row(
            children: [
              // Icône de notification
              GestureDetector(
                onTap: onNotificationPressed ?? () {},
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.notifications_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                ),
              ),

              // Titre (si présent)
              if (title != null) ...[
                SizedBox(width: 16),
                Text(
                  title!,
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 20,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],

              // Cagnotte et Points (si activés)
              if (showCagnotte) ...[
                SizedBox(width: 16),
                BalanceContainer(),
              ],
            ],
          ),

          // Profil (Avatar)
          GestureDetector(
            onTap: () {
              // Navigation vers la page profil
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF2D6D7B),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'assets/images/logo_user.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BalanceContainer extends StatefulWidget {
  @override
  State<BalanceContainer> createState() => _BalanceContainerState();
}

class _BalanceContainerState extends State<BalanceContainer> {
  int _hycoinsBalance = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBalances();
  }

  Future<void> _loadBalances() async {
    try {
      final hyCoinsService = HyCoinsService();
      final balances = await hyCoinsService.getBalanceAndPoints();
      setState(() {
        _hycoinsBalance = balances['hycoins'] ?? 0;
        _isLoading = false;
      });
    } catch (e) {
      print("Erreur lors du chargement des soldes: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // HyCoins
        HyCoinsMini(
          balance: _hycoinsBalance,
          isLoading: _isLoading,
        ),
      ],
    );
  }
}
