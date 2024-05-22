import 'package:flutter/material.dart';

class RegisteredEvent extends StatelessWidget {
  final String title, date;

  const RegisteredEvent({
    super.key,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 2,
        bottom: 2,
      ),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: ListTile(
        textColor: Theme.of(context).colorScheme.onSecondaryContainer,
        title: Text(title),
        subtitle: Text(date),
        leading: const Icon(Icons.check_circle),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.cancel),
        ),
      ),
    );
  }
}
