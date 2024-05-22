import 'package:flutter/material.dart';

class EventThumb extends StatelessWidget {
  final String title, img;
  const EventThumb({
    super.key,
    required this.title,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.shortestSide * 0.2,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Image.asset(
              "images/$img",
              height: MediaQuery.of(context).size.shortestSide * 0.1,
            ),
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
