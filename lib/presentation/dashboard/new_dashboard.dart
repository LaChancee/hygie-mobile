import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/dashboard/context_card.dart';
import 'package:hygie_mobile/presentation/dashboard/dasboard_content.dart';
import 'package:hygie_mobile/presentation/dashboard/top_bar.dart';

class NewDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F7FA), // Bleu clair
              Color(0xFFE8F5E9), // Vert clair
              Color(0xFFF3E5F5), // Violet clair
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              // TopBar (Barre supérieure) - Fixe en haut
              SliverPersistentHeader(
                pinned: true,
                delegate: _TopBarDelegate(
                  minHeight: 60,
                  maxHeight: 60,
                  child: TopBar(),
                ),
              ),

              // CardsContext - Défilera avec le scroll
              SliverToBoxAdapter(
                child: CardsContext(),
              ),

              // ContentsDashboard (Widgets du Dashboard) - Restera en bas
              SliverToBoxAdapter(
                child: ContentsDashboard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Delegate pour le SliverPersistentHeader
class _TopBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _TopBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_TopBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
