import 'package:flutter/material.dart';

class RegisterEvent extends StatelessWidget {
  final String? eventID = "1";
  const RegisterEvent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reserve your seat"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const EventHeader(
                title: "Welcome Party",
                date: "May 28, 2024",
                img: "ev1.jpg",
              ),
              Text(
                "Supported Payment Methods",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PaymentMethodShowCase(
                    paymentMethod: "JazzCash",
                    title: "Asad Nadeem",
                    paymentID: "0321 7865432",
                  ),
                  PaymentMethodShowCase(
                    paymentMethod: "EasyPaisa",
                    title: "Javed Akbar",
                    paymentID: "0347 7876489",
                  )
                ],
              ),
              Text(
                "Guidelines",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("1. Input payment phone number."),
                  Text("2. Make payment on the account given above."),
                  Text("3. Copy Transaction ID and paste that ID here."),
                  Text("4. Wait for approval"),
                ],
              ),
              Text(
                "Payment Details",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Row(
                children: [
                  Text(
                    "Selected Method   ",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const DropdownMenu(
                    hintText: "Payment Method",
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                        value: "value",
                        label: "JazzCash",
                      ),
                      DropdownMenuEntry(
                        value: "value",
                        label: "Easypaisa",
                      ),
                    ],
                  ),
                ],
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Payment Phone Number",
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Transaction ID",
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8.0),
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, "/ticket"),
                  child: const Text("Verify"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentMethodShowCase extends StatelessWidget {
  final String paymentMethod, paymentID, title;

  const PaymentMethodShowCase({
    super.key,
    required this.paymentMethod,
    required this.title,
    required this.paymentID,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              "images/${paymentMethod.toLowerCase()}.png",
              width: MediaQuery.of(context).size.shortestSide * 0.2,
            ),
          ),
          Text(paymentMethod),
          Text(title),
          Text(paymentID),
        ],
      ),
    );
  }
}

class EventHeader extends StatelessWidget {
  final String title, date, img;
  const EventHeader({
    super.key,
    required this.title,
    required this.date,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Colors.white),
      ),
      accountEmail: Text(
        date,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: Colors.white),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/$img"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
