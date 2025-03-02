import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/header.dart';
import 'package:hygie_mobile/presentation/recompense/hycoins_entete.dart';
import 'package:hygie_mobile/presentation/recompense/reward_card.dart'; // Importer RewardCard

class RecompensePage extends StatefulWidget {
  const RecompensePage({Key? key}) : super(key: key);

  @override
  _RecompensePageState createState() => _RecompensePageState();
}

class _RecompensePageState extends State<RecompensePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HycoinsHeader(),
            const SizedBox(height: 20),
            _buildSectionTitle('Offres tendances'), // Ajouter la nouvelle rubrique
            const SizedBox(height: 10),
            _buildOffresTendances(), // Ajouter la méthode pour les offres tendances
            const SizedBox(height: 20),
            _buildSectionTitle('Codes promo'),
            const SizedBox(height: 10),
            _buildPromoCodes(),
            const SizedBox(height: 20),
            _buildSectionTitle('Cadeaux'), // Remplacer "Virements" par "Cadeaux"
            const SizedBox(height: 10),
            _buildCadeaux(), // Remplacer _buildVirements par _buildCadeaux
            const SizedBox(height: 10), // Réduire l'espacement en dessous des cards
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

  Widget _buildOffresTendances() {
    return SizedBox(
      height: 200, // Hauteur ajustée
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          RewardCard(
            title: 'Amazon Prime Video',
            subtitle: '1 mois d’abonnement',
            hyCoins: 500,
          ),
          RewardCard(
            title: 'Decathlon',
            subtitle: '-25% sur une sélection d’articles',
            hyCoins: 300,
          ),
          RewardCard(
            title: 'HelloFresh',
            subtitle: 'Code promo : 95 €',
            hyCoins: 375,
          ),
        ],
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
          RewardCard(
            title: 'Amazon Prime Video',
            subtitle: '1 mois d’abonnement',
            hyCoins: 500,
          ),
        ],
      ),
    );
  }

  Widget _buildCadeaux() {
    return SizedBox(
      height: 200, // Hauteur ajustée
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          RewardCard(
            title: 'Gourde Hygie',
            subtitle: 'Gourde 500 ml',
            hyCoins: 900,
          ),
        ],
      ),
    );
  }
}
