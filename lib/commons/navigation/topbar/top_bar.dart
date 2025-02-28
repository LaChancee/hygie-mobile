import 'package:flutter/material.dart';

class CustomTopBar extends StatelessWidget {
  final String coinCount;
  final IconData coinIcon;
  final IconData actionIcon;

  const CustomTopBar({
    Key? key,
    required this.coinCount,
    required this.coinIcon,
    required this.actionIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Section gauche
          Row(
            children: [
              // Logo ou avatar
              Container(
                width: 32,
                height: 32,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const FlutterLogo(), // Remplacez par votre image/avatar
              ),
              const SizedBox(width: 16),
              // Badge des coins
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: ShapeDecoration(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(124),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x1E06214F),
                      blurRadius: 12,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      coinCount,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF044BD9),
                        fontSize: 14,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      coinIcon,
                      size: 16,
                      color: const Color(0xFF044BD9),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Section droite : Action
          Container(
            width: 32,
            height: 32,
            decoration: ShapeDecoration(
              color: const Color(0xFF808080),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(124),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x14222222),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                actionIcon,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
