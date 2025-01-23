import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/colors.dart';
import 'package:hygie_mobile/presentation/dashboard/consommation_form_screen.dart';

class HeaderDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/hygie_background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                'Non-fumeur depuis :',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                '2 jours',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: _buildActionButton(
                        context,
                        'Consommation',
                        () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ConsommationFormScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: _buildBilanButton('Bilan'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
      BuildContext context, String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(label, style: TextStyle(fontSize: 16)),
    );
  }

  Widget _buildBilanButton(String label) {
    return ElevatedButton(
      onPressed: () {
        // Action pour le bouton Bilan
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.2),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.white, width: 2),
        ),
      ),
      child: Text(label, style: TextStyle(fontSize: 16)),
    );
  }
}
