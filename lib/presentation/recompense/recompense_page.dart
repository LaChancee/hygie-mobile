import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/recompense/hycoins_entete.dart';
import 'package:hygie_mobile/presentation/recompense/reward_card';

class RecompensePage extends StatelessWidget {
  const RecompensePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.notifications, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'), // Image du profil
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HycoinsHeader(),
            const SizedBox(height: 20),
            _buildSectionTitle('Codes promo'),
            const SizedBox(height: 10),
            _buildPromoCodes(),
            const SizedBox(height: 20),
            _buildSectionTitle('Virements'),
            const SizedBox(height: 10),
            _buildVirements(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPromoCodes() {
    return SizedBox(
      height: 130, // Hauteur ajustée pour les cartes
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          RewardCard(
            title: 'HelloFresh',
            subtitle: 'Code promo : 95 €',
            hyCoins: 375,
            imagePath: 'assets/images/hellofresh.jpg',
          ),
          RewardCard(
            title: 'Nike',
            subtitle: 'Code promo : -15%',
            hyCoins: 425,
            imagePath: 'assets/nike.png',
          ),
        ],
      ),
    );
  }

  Widget _buildVirements() {
    return SizedBox(
      height: 130, // Hauteur ajustée pour les virements
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          RewardCard(
            title: '€10',
            subtitle: 'Virement bancaire',
            hyCoins: 1800,
            imagePath: 'assets/virement.png',
          ),
          RewardCard(
            title: '€30',
            subtitle: 'Virement bancaire',
            hyCoins: 3200,
            imagePath: 'assets/virement.png',
          ),
        ],
      ),
    );
  }
}
