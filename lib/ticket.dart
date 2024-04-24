import 'package:flutter/material.dart';

class GetTicket extends StatelessWidget {
  GetTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Get Your Ticket"),
      ),
    );
  }
}
