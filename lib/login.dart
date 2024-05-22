import 'package:event_master/dashboard.dart';
import 'package:event_master/device_storage.dart';
import 'package:event_master/firebase_storage.dart';
import 'package:event_master/firestore.dart';
import 'package:event_master/preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  bool passwordHidden = true;
  LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late String password, user;

  late bool admin;

  FireStoreStorage myFirestore = FireStoreStorage();
  FirebaseStorageHandle myFireStorage = FirebaseStorageHandle();
  LocalStorage myStorage = LocalStorage();
  Preferences preferences = Preferences();

  @override
  Widget build(BuildContext context) {
    preferences.reset().then(
          (value) => preferences.checkSession().then(
            (value) {
              if (value) Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        );
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Card(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: Text(
                        "Event Master",
                        textScaler: const TextScaler.linear(4),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                      hintText: "Input username",
                      labelText: "Username",
                    ),
                    onChanged: (value) => user = value,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.key),
                      hintText: "Input password",
                      labelText: "Password",
                      suffix: GestureDetector(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Icon(
                            widget.passwordHidden
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            widget.passwordHidden = !widget.passwordHidden;
                          });
                        },
                      ),
                    ),
                    onTapOutside: (event) {
                      setState(() {
                        widget.passwordHidden = true;
                      });
                    },
                    onChanged: (value) => password = value,
                    obscureText: widget.passwordHidden,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () async {
                        int results =
                            await myFirestore.authenticate(user, password);
                        if (context.mounted) {
                          if (results == 2) {
                            await preferences.initSession(
                                myFirestore.userID, myFirestore.userName);
                            var pic = await myFireStorage
                                .getFileData('profile_pics/$user');
                            await myStorage.saveProfilePic(pic);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return Dashboard(
                                userName: myFirestore.userName,
                                userID: myFirestore.userID,
                              );
                            }));
                          } else if (results == 1) {
                            await preferences.initSession(
                                myFirestore.userID, myFirestore.userName);
                            Navigator.pushReplacementNamed(context, '/admin');
                          } else {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Text(
                              "Invalid credentials",
                            )));
                          }
                        }
                      },
                      child: const Text("Login"),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Not registered still,"),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, '/signup'),
                        child: Text("Register now!"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
