import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/programme/single_programme.dart';

class ProgramSection extends StatelessWidget {
  const ProgramSection({Key? key}) : super(key: key);

  void _showProgramDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ModaleProgram(),
    );
  }

  Widget _buildProgramCard(
    BuildContext context, {
    required String title,
    required String description,
    required double progress,
    required int daysLeft,
  }) {
    return GestureDetector(
      onTap: () => _showProgramDetails(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF222222),
                fontSize: 16,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                color: Color(0xFF707070),
                fontSize: 14,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: const Color(0xFFDFE6EE),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF044BD9)),
                      minHeight: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '$daysLeft jours',
                  style: const TextStyle(
                    color: Color(0xFF044BD9),
                    fontSize: 14,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildProgramCard(
            context,
            title: 'Programme de sevrage tabagique',
            description:
                'Un programme personnalisé pour vous aider à arrêter de fumer progressivement',
            progress: 0.3,
            daysLeft: 21,
          ),
          _buildProgramCard(
            context,
            title: 'Gestion du stress',
            description:
                'Techniques et exercices pour mieux gérer le stress et réduire les envies',
            progress: 0.5,
            daysLeft: 15,
          ),
          _buildProgramCard(
            context,
            title: 'Activité physique',
            description:
                'Programme d\'exercices adaptés pour maintenir une bonne santé',
            progress: 0.7,
            daysLeft: 10,
          ),
        ],
      ),
    );
  }
}
