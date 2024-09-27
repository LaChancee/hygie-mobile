import 'package:flutter/widgets.dart';  // Utilise uniquement widgets.dart

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: _buildCustomGrid(),
          ),
          SizedBox(height: 20),  // Ajoute un espace en bas
          // Ajouter d'autres éléments ici si nécessaire
        ],
      ),
    );
  }

  Widget _buildCustomGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,   // Par exemple, 2 colonnes
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 4,   // Mettre le nombre d'éléments à afficher
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE), // Couleur du conteneur
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              'Élément $index',
              style: TextStyle(fontSize: 18, color: Color(0xFF333333)),
            ),
          ),
        );
      },
    );
  }
}
