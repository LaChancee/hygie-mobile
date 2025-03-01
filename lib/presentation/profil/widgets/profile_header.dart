import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileHeader extends StatelessWidget {
  final User? user;

  ProfileHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Prendre toute la largeur de l'écran
      height: 134,
      padding: const EdgeInsets.only(top: 5, left: 16), // Ajuster le padding pour décaler légèrement à droite
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 94,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 94,
                    height: 94,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: user?.photoURL != null
                            ? NetworkImage(user!.photoURL!)
                            : AssetImage('assets/images/logo_user.jpg') as ImageProvider,
                        fit: BoxFit.fill,
                      ),
                      shape: OvalBorder(
                        side: BorderSide(
                          width: 6,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: Color(0x7F044BD9),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.displayName ?? 'User Name',
                            style: TextStyle(
                              color: Color(0xFF044BD9),
                              fontSize: 20,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user?.email ?? 'Non renseigné',
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 14,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16), // Espace entre les informations et l'icône
          Container(
            padding: const EdgeInsets.all(16),
            child: Icon(Icons.edit, color: Colors.black), // Icône de crayon noir
          ),
        ],
      ),
    );
  }
}
