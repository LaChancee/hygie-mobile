import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/profil/profil_screen.dart';

class TopBar extends StatelessWidget {
  final bool showCagnotte;
  final VoidCallback? onNotificationPressed;

  const TopBar({
    Key? key,
    this.showCagnotte = true,
    this.onNotificationPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo + Notification
          Row(
            children: [
              // Icône de cloche outlined en couleur primaire (taille réduite)
              GestureDetector(
                onTap: onNotificationPressed ?? () {},
                child: Icon(
                  Icons.notifications_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
              ),
              if (showCagnotte) ...[
                SizedBox(width: 16),
                // Widget CagnotteMini
                CagnotteMini(),
              ],
            ],
          ),

          // Profil (Avatar avec l'image fournie)
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
    return Column(
      children: [
        Container(
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
        ),
      ],
    );
  }
}
