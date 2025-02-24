import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RewardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int hyCoins;

  const RewardCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.hyCoins,
  }) : super(key: key);

  String _getBackgroundImageForTitle(String title) {
    switch (title) {
      case 'HelloFresh':
        return 'assets/images/hellofresh.jpg';
      case 'Nike':
        return 'assets/images/nike.jpg';
      case 'Gourde Hygie':
        return 'assets/images/gourdehygie.jpg';
      case 'Amazon Prime Video':
        return 'assets/images/primevideo.jpg';
      case 'Decathlon':
        return 'assets/images/decathlon.jpg';
      default:
        return 'assets/images/default_image.png'; // Utiliser une image par défaut si nécessaire
    }
  }

  String _getLogoImageForTitle(String title) {
    switch (title) {
      case 'HelloFresh':
        return 'assets/images/hellofreshlogo.jpg';
      case 'Nike':
        return 'assets/images/nikelogo.jpg';
      case 'Gourde Hygie':
        return 'assets/images/hygielogo.jpg'; // Utiliser hygielogo.jpg à la place de hygielogo.svg
      case 'Amazon Prime Video':
        return 'assets/images/primevideologo.png';
      case 'Decathlon':
        return 'assets/images/decathlonlogo.jpg';
      default:
        return 'assets/images/default_logo.png'; // Utiliser une image par défaut si nécessaire
    }
  }

  @override
  Widget build(BuildContext context) {
    final String backgroundImagePath = _getBackgroundImageForTitle(title);
    final String logoImagePath = _getLogoImageForTitle(title);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 198,
        height: 157,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0x1E06214F),
              blurRadius: 12,
              offset: const Offset(0, 0),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 198,
                height: 85,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(backgroundImagePath),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 85,
              child: Container(
                height: 73,
                width: 198,
                padding: const EdgeInsets.all(16),
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 16,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Text(
                        subtitle,
                        style: const TextStyle(
                          color: Color(0xFF222222),
                          fontSize: 12,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 133,
              top: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: ShapeDecoration(
                  color: const Color(0x7F044BD9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x1E072250),
                      blurRadius: 12,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '$hyCoins',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 16,
                      height: 16,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: SvgPicture.asset(
                        'assets/images/Hygie.svg',
                        width: 16,
                        height: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 70,
              child: Container(
                width: 30,
                height: 30,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(360),
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    logoImagePath,
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
