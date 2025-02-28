import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/questionnaire/step1.dart';

class Bienvenue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF5F8FC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 54,
                        child: Container(
                          width: screenWidth,
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: FlutterLogo(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 118,
                        child: SizedBox(
                          width: screenWidth - 32,
                          child: Text(
                            'Bienvenue !',
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 32,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 176,
                        child: SizedBox(
                          width: screenWidth - 32,
                          child: Text(
                            'Avant de commencer, nous aimerions que vous répondiez à 5 petites questions afin que nous puissions te proposer une aide adaptée.',
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 14,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        bottom: 50,
                        child: SizedBox(
                          width: screenWidth - 32,
                          height: 50, // Ajoute une hauteur ici
                          child: GestureDetector(
                            onTap: () {
                              debugPrint("Bouton cliqué : Navigation en cours...");

                              Navigator.push(
                                context,
                                CupertinoPageRoute(builder: (context) => Step1()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF044BD9),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Center(
                                child: Text(
                                  'Suivant',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),



                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: screenWidth,
                          height: 54,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 54,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(50),
                                            topRight: Radius.circular(50),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: screenWidth,
                                              height: 54,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: double.infinity,
                                                      padding: const EdgeInsets.only(top: 18.34, bottom: 13.66),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          SizedBox(
                                                            width: 37.97,
                                                            child: Text(
                                                              '9:41',
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                color: Color(0xFF222222),
                                                                fontSize: 17,
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w600,
                                                                height: 1.29,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 111.15),
                                                  Container(
                                                    width: 139.43,
                                                    height: 54,
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: 27.33,
                                                          height: 13,
                                                          child: Stack(
                                                            children: [
                                                              Positioned(
                                                                left: 0,
                                                                top: 0,
                                                                child: Opacity(
                                                                  opacity: 0.35,
                                                                  child: Container(
                                                                    width: 25,
                                                                    height: 13,
                                                                    decoration: ShapeDecoration(
                                                                      shape: RoundedRectangleBorder(
                                                                        side: BorderSide(width: 1, color: Color(0xFF222222)),
                                                                        borderRadius: BorderRadius.circular(4.30),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                left: 2,
                                                                top: 2,
                                                                child: Container(
                                                                  width: 21,
                                                                  height: 9,
                                                                  decoration: ShapeDecoration(
                                                                    color: Color(0xFF222222),
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(2.50),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                          height: 30,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: screenWidth,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: screenWidth,
                                      height: 30,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Container(
                                              width: screenWidth,
                                              height: 30,
                                              decoration: BoxDecoration(color: Colors.white),
                                            ),
                                          ),
                                          Positioned(
                                            left: screenWidth * 0.68,
                                            top: 17,
                                            child: Transform(
                                              transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                                              child: Container(
                                                width: screenWidth * 0.36,
                                                height: 5,
                                                decoration: ShapeDecoration(
                                                  color: Color(0xFF222222),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(100),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
