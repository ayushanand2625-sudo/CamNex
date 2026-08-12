import 'package:flutter/material.dart';

class QuickAction
    extends StatelessWidget {

  final IconData icon;
  final String title;

  const QuickAction({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        CircleAvatar(
          radius: 30,
          child: Icon(icon),
        ),

        const SizedBox(height: 10),

        Text(title),
      ],
    );
  }
}