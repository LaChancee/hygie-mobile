import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/header.dart';
import 'package:hygie_mobile/presentation/recompense/hycoins_entete.dart';
import 'package:hygie_mobile/presentation/recompense/reward_card';

class RecompensePage extends StatelessWidget {
  const RecompensePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: '',
        onNotificationPressed: () {
          // Action à réaliser lorsque le bouton de notification est pressé
          print('Notification pressée');
        },
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
      height: 200, // Hauteur ajustée
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          RewardCard(
            title: 'HelloFresh',
            subtitle: 'Code promo : 95 €',
            hyCoins: 375,
          ),
          RewardCard(
            title: 'Nike',
            subtitle: 'Code promo : -15%',
            hyCoins: 425,
          ),
        ],
      ),
    );
  }

  Widget _buildVirements() {
    return SizedBox(
      height: 200, // Hauteur ajustée
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          RewardCard(
            title: '€10',
            subtitle: 'Virement bancaire',
            hyCoins: 1800,
          ),
          RewardCard(
            title: '€30',
            subtitle: 'Virement bancaire',
            hyCoins: 3200,
          ),
        ],
      ),
    );
  }
}
