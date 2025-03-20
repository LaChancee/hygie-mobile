import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/recompense/recompense_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListHistorique extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 358,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x19072250),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFFDDD4FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    color: Color(0xFF222222),
                    size: 24,
                  ),
                ),
                const SizedBox(height: 24),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Amazon Prime Video',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 16,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '8 juin 2024, 21:48',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF707070),
                            fontSize: 12,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w400,
                            height: 1.31,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Coût en hycoins',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 12,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 1.31,
                                ),
                              ),
                              Text(
                                '375',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 12,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Valable jusqu\'au',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 12,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 1.31,
                                ),
                              ),
                              Text(
                                '12/12/2026',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 12,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      height: 1,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFDAE0F6),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Mon code',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 16,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: ShapeDecoration(
                            color: Color(0xFFDFE6EE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'AB12-DH7O-8JSN',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 16,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.copy,
                                color: Color(0xFF222222),
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RecapitulatifAchat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Text(
                  'Récapitulatif de ma commande',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 16,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Amazon Prime Video',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 20,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '1 mois d\'abonnement',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Plongez dans un univers de divertissement illimité avec Amazon Prime Video ! Profitez d\'un accès exclusif à des milliers de films, séries télévisées captivantes, documentaires fascinants et contenus originaux primés.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ListHistorique(),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  final userDoc = await FirebaseFirestore.instance
                      .collection('profil')
                      .doc(user.uid)
                      .get();
                  
                  if (userDoc.exists) {
                    final currentPoints = userDoc.data()?['points'] ?? 0;
                    final remainingPoints = currentPoints - 375; // 375 est le coût de l'achat
                    
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      builder: (context) {
                        return RecompensePage(remainingPoints: remainingPoints);
                      },
                    );
                  }
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: ShapeDecoration(
                  color: const Color(0xFF044BD9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'Valider',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}