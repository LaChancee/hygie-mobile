import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hygie_mobile/presentation/dashboard/top_bar.dart';

class DashboardTab extends StatefulWidget {
  @override
  _DashboardTabState createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(),
        Text('Counter: $counter'),
        ElevatedButton(
          onPressed: increment,
          child: Text('Increment'),
        ),
      ],
    );
  }
}
