import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Icon',
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 10
        ),),

      ],
    );
  }
}
