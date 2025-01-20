import 'package:flutter/material.dart';

class CustomNavbar extends StatefulWidget {
  const CustomNavbar({Key? key}) : super(key: key);

  @override
  _CustomNavbarState createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  int _selectedIndex = 0;

  // Liste des éléments de la navbar
  final List<_NavbarItem> _navbarItems = [
    _NavbarItem(icon: Icons.dashboard, label: 'Dashboard'),
    _NavbarItem(icon: Icons.book, label: 'Journal'),
    _NavbarItem(icon: Icons.star, label: 'Récompenses'),
    _NavbarItem(icon: Icons.flag, label: 'Objectifs'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0x1406214F),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          _navbarItems.length,
              (index) {
            final isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _navbarItems[index].icon,
                    size: 24,
                    color: isSelected ? const Color(0xFF044BD9) : const Color(0xFF707070),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _navbarItems[index].label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? const Color(0xFF044BD9) : const Color(0xFF707070),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Classe pour structurer les éléments de la navbar
class _NavbarItem {
  final IconData icon;
  final String label;

  const _NavbarItem({required this.icon, required this.label});
}
