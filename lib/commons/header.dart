import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/profil/profil_screen.dart';
import 'package:hygie_mobile/presentation/dashboard/top_bar.dart';

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
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: TopBar(
          showCagnotte: false,
          onNotificationPressed: onNotificationPressed,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
