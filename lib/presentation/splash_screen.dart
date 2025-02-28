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
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent, // Fond transparent
            builder: (BuildContext context) {
              return _buildBlurredModal();
            },
          );
        }
      });
    });
  }

  Widget _buildBlurredModal() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Ajuster le flou
      child: Container(
        color: Colors.transparent, // Couleur de fond avec opacité
        child: ContentsArrival(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Fond avec formes colorées
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: Stack(
                children: [
                  Positioned(
                    left: screenWidth * 0.65,
                    top: screenHeight * 0.45,
                    child: _buildColoredOval(screenWidth * 0.4,
                        screenHeight * 0.4, Color(0xB2A885FF)),
                  ),
                  Positioned(
                    left: screenWidth * 0.1,
                    top: screenHeight * 0.6,
                    child: _buildColoredOval(screenWidth * 0.8,
                        screenHeight * 0.4, Color(0xFFB2F99D)),
                  ),
                  Positioned(
                    left: -screenWidth * 0.2,
                    top: screenHeight * 0.4,
                    child: _buildColoredOval(screenWidth * 0.5,
                        screenHeight * 0.6, Color(0xFF80D1FF)),
                  ),
                ],
              ),
            ),
          ),

          // Logo centré
          Center(
            child: Image.asset(
              'assets/images/HygieBlack.png',
              width: screenWidth * 0.4,
              height: screenHeight * 0.2,
              fit: BoxFit.contain,
            ),
          ),

          // Texte sous le logo
          Align(
            alignment: Alignment(0.0, 0.3),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Nous sommes heureux de pouvoir vous accompagner !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6C33FF),
                  fontSize: screenWidth * 0.05, // Responsive font size
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Indicateur bas
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
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
    );
  }

  // Fonction pour construire un ovale coloré avec une opacité
  Widget _buildColoredOval(double width, double height, Color color) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: color.withOpacity(0.5),
        shape: OvalBorder(),
      ),
    );
  }
}
