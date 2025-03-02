import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/header.dart';
import 'package:hygie_mobile/presentation/recompense/hycoins_entete.dart';
import 'package:hygie_mobile/presentation/recompense/reward_card';

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
            Header(
              title: '',
              onNotificationPressed: () {
                // Action à réaliser lorsque le bouton de notification est pressé
                print('Notification pressée');
              },
            ),

            // TabBar pour basculer entre les sections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black54,
                indicator: BoxDecoration(
                  color: const Color.fromRGBO(4, 75, 217, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                tabs: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: const Tab(text: "Récompenses"),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: const Tab(text: "Historique"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Contenu des onglets
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Premier onglet - Récompenses
                  SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
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
                        const SizedBox(
                            height: 80), // Espace supplémentaire pour la TabBar
                      ],
                    ),
                  ),

                  // Deuxième onglet - Historique
                  Center(
                    child: Text(
                      'Historique des récompenses',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
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
