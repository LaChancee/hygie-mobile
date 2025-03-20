import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/profil/profil_screen.dart';
import '../../data/services/hycoins_service.dart';
import '../../data/services/profile_service.dart';
import '../../widgets/hycoins_mini.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    // Récupérer l'email de l'utilisateur connecté
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;
    final bool isSpecialUser = userEmail == 'toto@toto.fr';

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
              child: isSpecialUser
                  ? Image.asset(
                      'assets/images/pdpMDP.jpg',
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('profil')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return HyCoinsMini(
            balance: 0,
            isLoading: true,
          );
        }

        if (snapshot.hasError) {
          print("Erreur lors de la récupération des points: ${snapshot.error}");
          return HyCoinsMini(
            balance: 0,
            isLoading: false,
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return HyCoinsMini(
            balance: 0,
            isLoading: false,
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final points = data['points'] ?? 0;

        return HyCoinsMini(
          balance: points,
          isLoading: false,
        );
      },
    );
  }
}
