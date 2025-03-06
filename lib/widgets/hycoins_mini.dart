import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HyCoinsMini extends StatelessWidget {
  final int balance;
  final bool isLoading;
  final bool useBlueIcon;
  final Color textColor;
  final Color backgroundColor;

  const HyCoinsMini({
    Key? key,
    required this.balance,
    this.isLoading = false,
    this.useBlueIcon = true,
    this.textColor = const Color(0xFF044BD9),
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(124),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x1E06214F),
            blurRadius: 12,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isLoading)
            Container(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: textColor,
              ),
            )
          else
            Text(
              '$balance',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontFamily: 'DM sans',
                fontWeight: FontWeight.w500,
              ),
            ),
          SizedBox(width: 4),
          Container(
            width: 16,
            height: 16,
            child: useBlueIcon
                ? Image.asset('assets/images/blue_hycoins.png')
                : Image.asset('assets/images/hycoins.png'),
          ),
        ],
      ),
    );
  }
}

class PointsMini extends StatelessWidget {
  final int points;
  final bool isLoading;
  final Color textColor;
  final Color backgroundColor;

  const PointsMini({
    Key? key,
    required this.points,
    this.isLoading = false,
    this.textColor = const Color(0xFF6C33FF),
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(124),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x1E06214F),
            blurRadius: 12,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isLoading)
            Container(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: textColor,
              ),
            )
          else
            Text(
              '$points',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontFamily: 'DM sans',
                fontWeight: FontWeight.w500,
              ),
            ),
          SizedBox(width: 4),
          Icon(
            Icons.star,
            color: textColor,
            size: 16,
          ),
        ],
      ),
    );
  }
}
