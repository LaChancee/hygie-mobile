import 'package:flutter/material.dart';

class ResponsiveTabBar extends StatelessWidget {
  final List<Map<String, dynamic>> tabs = [
    {"icon": Icons.dashboard, "label": "Dashboard", "isActive": true},
    {"icon": Icons.book, "label": "Journal", "isActive": false},
    {"icon": Icons.card_giftcard, "label": "Récompenses", "isActive": false},
    {"icon": Icons.flag, "label": "Objectifs", "isActive": false},
  ];

  Widget buildTabItem(BuildContext context, IconData icon, String label, bool isActive) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: isActive ? Colors.blue : Colors.grey),
          SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? Colors.blue : Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 24,
            offset: Offset(0, -8),
          )
        ],
      ),
      child: screenWidth > 400
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: tabs.map((tab) => buildTabItem(context, tab["icon"], tab["label"], tab["isActive"])).toList(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: tabs.map((tab) => buildTabItem(context, tab["icon"], tab["label"], tab["isActive"])).toList(),
              ),
            ),
    );
  }
}
