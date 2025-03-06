import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hygie_mobile/commons/header.dart';
import 'package:hygie_mobile/presentation/dashboard/header_dashboard.dart'; // Assurez-vous que le chemin est correct
import 'package:hygie_mobile/presentation/dashboard/test_button.dart'; // Assurez-vous que le chemin est correct
import 'package:hygie_mobile/presentation/dashboard/widget_dashboard.dart'; // Assurez-vous que le chemin est correct
import 'package:hygie_mobile/presentation/dashboard/discover_button.dart'; // Assurez-vous que le chemin est correct
import 'package:hygie_mobile/presentation/dashboard/content_dashboard.dart'; // Importez le contenu du dashboard

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar, qui se rétrécit au scroll
          SliverAppBar(
            title: Header(
              title: '',
            ),
            expandedHeight: 300.0,
            // Hauteur de l'expansion
            floating: false,
            // Le header ne flotte pas au-dessus
            pinned: true,
            // Le header reste visible quand on scrolle
            flexibleSpace: FlexibleSpaceBar(
              background: HeaderDashboard(),
              centerTitle: true,
            ),
          ),

          // Tout le contenu du dashboard dans un seul SliverToBoxAdapter
          SliverToBoxAdapter(
            child:
                ContentsDashboard(), // Utilise directement le composant ContentsDashboard
          ),
        ],
      ),
    );
  }
}
