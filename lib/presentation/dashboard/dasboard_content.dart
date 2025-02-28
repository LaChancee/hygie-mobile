import 'package:flutter/material.dart';

class ContentsDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = MediaQuery.of(context).size.width;
        bool isLargeScreen = screenWidth > 600; // Différenciation mobile/tablette

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: isLargeScreen ? 500 : double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDependencyTestCard(isLargeScreen),
                const SizedBox(height: 16),
                _buildSectionTitle('Mes widgets'),
                const SizedBox(height: 16),
                _buildAddWidgetButton(),
                const SizedBox(height: 16),
                _buildOfferCard(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDependencyTestCard(bool isLargeScreen) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xFFF5F8FC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xB2A885FF),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Testez votre niveau de dépendance',
                  style: TextStyle(
                    color: Color(0xFF6C33FF),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Fixez-vous des objectifs et obtenez des données plus détaillées.',
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          if (isLargeScreen) const SizedBox(width: 16),
          _buildScoreBadge(),
        ],
      ),
    );
  }

  Widget _buildScoreBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0x7F044BD9),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          Text(
            '375',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.star, color: Colors.white, size: 16),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0xFF044BD9),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Icon(Icons.widgets, color: Color(0xFF044BD9)),
      ],
    );
  }

  Widget _buildAddWidgetButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Color(0xFFF5F8FC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFDAE0F6)),
      ),
      child: Column(
        children: [
          Icon(Icons.add_circle_outline, color: Color(0xFF044BD9), size: 24),
          const SizedBox(height: 8),
          Text(
            'Ajouter un widget',
            style: TextStyle(
              color: Color(0xFF044BD9),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF044BD9), width: 2),
      ),
      child: Column(
        children: [
          Text(
            'Découvrez notre offre Hygie+ !',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF044BD9),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPriceOption('3,99€ /mois', Color(0xFF044BD9)),
              const SizedBox(width: 8),
              _buildPriceOption('32,99€ /an', Color(0xFF84F266)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Accédez à des outils supplémentaires, des programmes de sevrage et obtenez des récompenses supplémentaires pour chaque effort !',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF222222),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward, color: Colors.white),
            label: Text('Découvrir'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF044BD9),
              shape: StadiumBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceOption(String price, Color borderColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        price,
        style: TextStyle(
          color: Color(0xFF222222),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
