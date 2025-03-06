import 'package:flutter/material.dart';

class NotificationGain extends StatelessWidget {
  final String message;
  final int amount;
  final IconData? icon;
  final VoidCallback? onClose;

  const NotificationGain({
    Key? key,
    required this.message,
    required this.amount,
    this.icon,
    this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        width: double.infinity,
        height: 74,
        padding: const EdgeInsets.all(16),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x19072250),
              blurRadius: 12,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 42,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icône de gauche
                    Container(
                      padding: const EdgeInsets.all(8),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFDDD4FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      child: Icon(
                        icon ?? Icons.check_circle_outline,
                        size: 24,
                        color: const Color(0xFF8352FF),
                      ),
                    ),

                    // Message
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          message,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 16,
                            fontFamily: 'DM sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    // Badge HyCoins
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFDAE0F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '+ $amount',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xFF044BD9),
                              fontSize: 12,
                              fontFamily: 'DM sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Image.asset(
                            'assets/images/hycoins.png',
                            width: 16,
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Affiche une notification de gain qui apparaît depuis le haut de l'écran
void showGainNotification(
  BuildContext context, {
  required String message,
  required int amount,
  IconData? icon,
  Duration duration = const Duration(seconds: 3),
}) {
  // Overlay qui permet d'afficher des widgets au-dessus de tout
  OverlayState? overlayState = Overlay.of(context);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) {
      return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: -100.0, end: 0.0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            builder: (BuildContext context, double value, Widget? child) {
              return Transform.translate(
                offset: Offset(0, value),
                child: child,
              );
            },
            child: SafeArea(
              child: GestureDetector(
                onTap: () {
                  overlayEntry.remove();
                },
                child: NotificationGain(
                  message: message,
                  amount: amount,
                  icon: icon,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );

  // Insère l'overlay et programme sa suppression
  overlayState?.insert(overlayEntry);

  // Supprime l'overlay après la durée spécifiée
  Future.delayed(duration, () {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
  });
}
