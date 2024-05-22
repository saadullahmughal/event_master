import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "EventMaster",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Text("v1.0"),
            const Text("Muhammad Saadullah Zafar"),
          ],
        ),
      ),
    );
  }
}
