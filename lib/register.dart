import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';

class RegisterEvent extends StatelessWidget {
  String? eventID = "1";
  RegisterEvent({
    super.key,
    this.eventID,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reserve your seat"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  "Welcome Party",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                ),
                accountEmail: Text(
                  'May 28, 2024',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/ev1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                "Supported Payment Methods",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "images/jazzcash.png",
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.2,
                          ),
                        ),
                        Text("JazzCash"),
                        Text("Asad Nadeem"),
                        Text("0321 7865432"),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "images/easypaisa.png",
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.2,
                          ),
                        ),
                        Text("EasyPaisa"),
                        Text("Javed Akbar"),
                        Text("0347 7876489"),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                "Guidelines",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Column(
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
                  DropdownMenu(
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
              TextField(
                decoration: InputDecoration(
                  labelText: "Payment Phone Number",
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Transaction ID",
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.0),
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, "/ticket"),
                  child: Text("Verify"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
