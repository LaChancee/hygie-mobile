import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'package:hygie_mobile/presentation/authentification/modal_auth.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    // Afficher la modal après 2 secondes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          _showAuthModal();
        }
      });
    });
  }

  void _showAuthModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
      ),
      builder: (BuildContext context) {
        return ContentsArrival();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double safeAreaTop = MediaQuery.of(context).padding.top;
    final double safeAreaBottom = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Fond avec dégradé de couleur
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xB2A885FF).withOpacity(0.4), // Violet
                    Color(0xFFB2F99D).withOpacity(0.4), // Vert
                    Color(0xFF80D1FF).withOpacity(0.4), // Bleu
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),

            // Effet de flou léger pour adoucir le dégradé
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),

            // Contenu principal
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo centré
                    Image.asset(
                      'assets/images/HygieBlack.png',
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.15,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: screenHeight * 0.04),

                    // Texte sous le logo
                    Text(
                      'Nous sommes heureux de pouvoir vous accompagner !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF6C33FF),
                        fontSize: screenWidth * 0.045, // Responsive font size
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Indicateur bas
            Positioned(
              bottom: 20 + safeAreaBottom,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: screenWidth * 0.3,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Color(0xFF222222),
                    borderRadius: BorderRadius.circular(100),
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
