import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo + Notification
          Row(
            children: [
              // Logo
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: FlutterLogo(),
              ),
              SizedBox(width: 16),
              // Notification Badge (adapté aux petits écrans)
              if (screenWidth > 600) 
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(124),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x1E06214F),
                        blurRadius: 12,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        '0',
                        style: TextStyle(
                          color: Color(0xFF044BD9),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.notifications, color: Colors.blue, size: 16),
                    ],
                  ),
                ),
            ],
          ),

          // Profil (Avatar)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
