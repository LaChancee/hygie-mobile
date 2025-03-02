import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/profil/profil_screen.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showProfileImage;
  final VoidCallback? onNotificationPressed;

  const Header({
    Key? key,
    required this.title,
    this.showProfileImage = true,
    this.onNotificationPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.notifications, color: Colors.black),
        onPressed: onNotificationPressed ?? () {},
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        if (showProfileImage)
          GestureDetector(
            onTap: () {
              // Naviguer vers l'écran profil
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo_user.png'), // Image du profil
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
