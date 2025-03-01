import 'package:flutter/material.dart';

class ProfileBadges extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 143,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 19,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Badges',
                      style: TextStyle(
                        color: Color(0xFF044BD9),
                        fontSize: 14,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BadgeItem(imageUrl: 'assets/images/badge1.png', color: Color(0xFFDDD4FF)),
                      const SizedBox(width: 8),
                      BadgeItem(imageUrl: 'assets/images/badge1.png', color: Color(0xFFDAE0F6)),
                      const SizedBox(width: 8),
                      BadgeItem(imageUrl: 'assets/images/badge1.png', color: Color(0xFFDAE0F6)),
                      const SizedBox(width: 8),
                      BadgeItem(imageUrl: 'assets/images/badge1.png', color: Color(0xFFDAE0F6)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BadgeItem extends StatelessWidget {
  final String imageUrl;
  final Color color;

  BadgeItem({required this.imageUrl, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Image.asset(imageUrl, width: 100, height: 100, fit: BoxFit.fill),
    );
  }
}