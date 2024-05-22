import 'package:flutter/material.dart';

class OrganizerShowcase extends StatelessWidget {
  final String title;
  const OrganizerShowcase({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(
            "images/${title.toLowerCase()}.jpg",
            height: MediaQuery.of(context).size.shortestSide * 0.15,
          ),
        ),
        Text(
          title,
        )
      ],
    );
  }
}
