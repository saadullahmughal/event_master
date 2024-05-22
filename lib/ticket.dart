import 'package:flutter/material.dart';

class GetTicket extends StatelessWidget {
  const GetTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Get Your Ticket"),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.shortestSide * 0.6,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.shortestSide * 0.1,
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "images/qr.png",
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(
                  bottom: 40.0,
                ),
                child: Text(
                  "Ticket Details",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Event:"),
                  Text("Welcome Party"),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Attendee ID:"),
                  Text("2021-CS-414"),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Ticket ID:"),
                  Text("H8HX768"),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 40.0),
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Save"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
