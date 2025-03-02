import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/profil/profil_screen.dart';

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

              // Cagnotte (si activée)
              if (showCagnotte) ...[
                SizedBox(width: 16),
                CagnotteMini(),
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

class CagnotteMini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 66,
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(124),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x1E06214F),
            blurRadius: 12,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '0',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF044BD9),
              fontSize: 14,
              fontFamily: 'DM sans',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 4),
          Container(
            width: 16,
            height: 16,
            child: Image.asset('assets/images/blue_hycoins.png'),
          ),
        ],
      ),
    );
  }
}
