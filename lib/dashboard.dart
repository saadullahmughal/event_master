import 'dart:io';

import 'package:event_master/device_storage.dart';
import 'package:event_master/preferences.dart';

import 'organizer_showcase.dart';
import 'event_thumb.dart';
import 'registered_event.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  String? dir;
  bool loaded = false;
  Dashboard({this.userName, this.userID, super.key}) {
    print(userName.toString() + userID.toString());
  }

  String? userName = "Loading...", userID = "Loading...";

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Preferences preferences = Preferences();

  @override
  void initState() {
    LocalStorage.getDocDir().then((value) => setState(() {
          widget.dir = value;
          widget.loaded = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if (value == 1) Navigator.pushNamed(context, "/about");
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "About",
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.cyan,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("Saadullah"),
              accountEmail: const Text("2021-CS-414"),
              currentAccountPicture: ClipOval(
                child: widget.loaded
                    ? Image.file(File("${widget.dir}/profile_pic"))
                    : Icon(Icons.face),
              ),
              otherAccountsPictures: const [
                Icon(Icons.edit),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Row(
          children: [
            Icon(Icons.event_note),
            Text("EventMaster"),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await preferences.closeSession();
              Navigator.pushNamedAndRemoveUntil(
                  context, "/login", (route) => false);
            },
          ),
          Container(
            width: MediaQuery.of(context).size.width / 80,
          )
        ],
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: ListTile(
                textColor: Theme.of(context).colorScheme.onSecondary,
                minLeadingWidth: 50,
                contentPadding: const EdgeInsets.all(8.0),
                leading: ClipOval(
                  child: Image.file(
                    File("${widget.dir}/profile_pic"),
                  ),
                ),
                title: Text(widget.userName.toString(),
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineLarge?.fontSize,
                    )),
                subtitle: Text(
                  widget.userID.toString(),
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.shortestSide * 0.1,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: ListTile(
                textColor: Theme.of(context).colorScheme.onSecondary,
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Famous",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge?.fontSize,
                      ),
                    ),
                    Text(
                      "Organizers",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge?.fontSize,
                      ),
                    ),
                  ],
                ),
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OrganizerShowcase(title: "ProSoft"),
                    OrganizerShowcase(title: "UET Tribune"),
                    OrganizerShowcase(title: "CDES"),
                  ],
                ),
                minVerticalPadding:
                    MediaQuery.of(context).size.shortestSide * 0.05,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.shortestSide * 0.05,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: ListTile(
                textColor: Theme.of(context).colorScheme.onSecondary,
                leading: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event,
                      ),
                      Text("Recent"),
                      Text("Events"),
                    ],
                  ),
                ),
                title: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Scrollbar(
                    child: Table(
                      defaultColumnWidth: FixedColumnWidth(
                        MediaQuery.of(context).size.width * 0.36,
                      ),
                      children: [
                        TableRow(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, "/register"),
                              child: const EventThumb(
                                title: "Welcome Party",
                                img: "ev1.jpg",
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, "/register"),
                              child: const EventThumb(
                                title: "Open Day 2024",
                                img: "ev2.webp",
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, "/register"),
                              child: const EventThumb(
                                title: "Farewell Party",
                                img: "ev3.jpg",
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, "/register"),
                              child: const EventThumb(
                                title: "Alumni Gathering",
                                img: "ev2.webp",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.shortestSide * 0.05,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              height: MediaQuery.of(context).size.longestSide * 0.3,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.longestSide * 0.05,
                bottom: MediaQuery.of(context).size.longestSide * 0.05,
                right: 8.0,
                left: 8.0,
              ),
              alignment: Alignment.center,
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    // const Text("You have no registrations yet"),
                    RegisteredEvent(
                      title: "Welcome Party",
                      date: "May 28, 2024",
                    ),
                    RegisteredEvent(
                      title: "Fairwell Party",
                      date: "April 24, 2024",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
