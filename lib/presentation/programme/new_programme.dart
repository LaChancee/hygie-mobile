import 'package:flutter/material.dart';

class NewProgrammePage extends StatefulWidget {
  const NewProgrammePage({Key? key}) : super(key: key);

  @override
  _NewProgrammePageState createState() => _NewProgrammePageState();
}

class _NewProgrammePageState extends State<NewProgrammePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF5F8FC),
      appBar: AppBar(
        title: Text(
          'Nouveau programme',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          padding: EdgeInsets.only(top: screenHeight * 0.03),
          child: Column(
            children: [
              Container(
                width: screenWidth,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Retrouvez ce programme pour mieux performer par rapport à vos objectifs !',
                      style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: screenWidth * 0.05,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildSection(
                      context: context,
                      title: 'Préparation au sevrage',
                      items: [
                        _ProgramItem(
                          title:
                              "Identifier les déclencheurs de l'envie de fumer",
                          subtitle: "Palier atteint après 12 heures.",
                          points: 20,
                        ),
                        _ProgramItem(
                          title: "Faire des exercices de relaxation",
                          subtitle: "Palier atteint après 24 heures.",
                          points: 20,
                        ),
                      ],
                    ),
                    _buildSection(
                      context: context,
                      title: 'Sevrage progressif et gestion des symptômes',
                      items: [
                        _ProgramItem(
                          title:
                              "Augmenter l'activité physique pour réduire les envies",
                          subtitle: "Palier atteint après 2 jours",
                          points: 20,
                        ),
                        _ProgramItem(
                          title:
                              "Utiliser des substituts de la nicotine de manière progressive",
                          subtitle: "Palier atteint après 2 jours",
                        ),
                      ],
                    ),
                    _buildSection(
                      context: context,
                      title: 'Consolidation et prévention des rechutes',
                      items: [
                        _ProgramItem(
                          title:
                              "Pratiquer la méditation de pleine conscience pour maintenir la sérénité",
                          subtitle: "Palier atteint après 2 jours",
                        ),
                        _ProgramItem(
                          title:
                              "Renforcer les liens de soutien pour éviter la rechute",
                          subtitle: "Palier atteint après 2 jours",
                        ),
                      ],
                    ),
                    _buildSection(
                      context: context,
                      title: 'Suivi et ressources complémentaires',
                      items: [
                        _ProgramItem(
                          title: "Suivi régulier des progrès",
                          subtitle: "Palier atteint après 2 jours",
                          points: 20,
                        ),
                        _ProgramItem(
                          title:
                              "Renforcer les mécanismes de relaxation et de gestion du stress",
                          subtitle: "Palier atteint après 2 jours",
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                // TODO: Implement program addition
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF044BD9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                minimumSize: Size(double.infinity, 56),
              ),
              child: Text(
                'Ajouter le programme',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color(0xFF044BD9), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                minimumSize: Size(double.infinity, 56),
              ),
              child: Text(
                'Retour',
                style: TextStyle(
                  color: Color(0xFF044BD9),
                  fontSize: 16,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required List<_ProgramItem> items,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
          child: Text(
            title,
            style: TextStyle(
              color: Color(0xFF222222),
              fontSize: 14,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ...items.map((item) => _buildProgramItemCard(context, item)).toList(),
      ],
    );
  }

  Widget _buildProgramItemCard(BuildContext context, _ProgramItem item) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: screenWidth * 0.03),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x19072250),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 14,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: TextStyle(
                        color: Color(0xFF707070),
                        fontSize: 12,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              if (item.points != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: ShapeDecoration(
                    color: Color(0xFFDAE0F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '+ ${item.points}',
                        style: TextStyle(
                          color: Color(0xFF044BD9),
                          fontSize: 12,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: screenWidth * 0.02),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: 0.0,
              backgroundColor: Color(0xFFDFE6EE),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8352FF)),
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgramItem {
  final String title;
  final String subtitle;
  final int? points;

  _ProgramItem({
    required this.title,
    required this.subtitle,
    this.points,
  });
}
