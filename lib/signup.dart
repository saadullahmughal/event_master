import 'dart:io';

import 'package:event_master/firestore.dart';
import 'package:event_master/preferences.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class SignupWidget extends StatefulWidget {
  bool passwordHidden = true,
      validUser = false,
      //validPassword = false,
      matchPassword = false,
      inProgress = false,
      enabled = false,
      imageSelected = false;
  XFile? img;
  SignupWidget({super.key});

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  late String password = "", confirmPassword = "", user = "", name = "";

  late bool admin;

  FireStoreStorage storage = FireStoreStorage();

  Preferences preferences = Preferences();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: widget.inProgress
              ? const Column(
                  children: [
                    CircularProgressIndicator(),
                    Text("Processing your request..."),
                  ],
                )
              : SingleChildScrollView(
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
                              textScaler: const TextScaler.linear(2),
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(0, 255, 255, 255)),
                            borderRadius: BorderRadius.circular(
                              MediaQuery.sizeOf(context).shortestSide * 0.25,
                            ),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          height: MediaQuery.sizeOf(context).shortestSide * 0.5,
                          width: MediaQuery.sizeOf(context).shortestSide * 0.5,
                          child: GestureDetector(
                            child: ClipOval(
                              child: !widget.imageSelected
                                  ? Icon(
                                      Icons.add_photo_alternate,
                                      color: Colors.white,
                                      size: MediaQuery.sizeOf(context)
                                              .shortestSide *
                                          0.35,
                                    )
                                  : Image.file(
                                      File(widget.img!.path),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            onTap: () async {
                              ImagePicker picker = ImagePicker();
                              widget.img = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (widget.img != null) {
                                setState(() {
                                  widget.imageSelected = true;
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                            hintText: "Select a unique username",
                            labelText: "Username",
                            suffix: GestureDetector(
                              child: Icon(widget.validUser
                                  ? Icons.check_circle
                                  : Icons.warning),
                            ),
                          ),
                          //enabled: widget.enabled,
                          onChanged: (value) async {
                            user = value;
                            setState(() {
                              //widget.enabled = false;
                            });
                            bool userExists = await storage.userExists(value);
                            setState(() {
                              widget.validUser = !userExists;
                              widget.enabled = widget.matchPassword &&
                                  widget.validUser &&
                                  password.isNotEmpty;
                              //widget.enabled = true;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextField(
                          //enabled: widget.enabled,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                            hintText: "Input your name",
                            labelText: "Display Name",
                          ),
                          onChanged: (value) => name = value,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextField(
                          //enabled: widget.enabled,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.key),
                            hintText: "Select a strong password",
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
                                  widget.passwordHidden =
                                      !widget.passwordHidden;
                                });
                              },
                            ),
                          ),
                          onTapOutside: (event) {
                            setState(() {
                              widget.passwordHidden = true;
                            });
                          },
                          onChanged: (value) {
                            password = value;
                            setState(() {
                              widget.matchPassword =
                                  password == confirmPassword;
                              widget.enabled =
                                  widget.matchPassword && widget.validUser;
                            });
                          },
                          obscureText: widget.passwordHidden,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextField(
                          //enabled: widget.enabled,

                          decoration: InputDecoration(
                            focusColor: widget.matchPassword
                                ? Colors.green
                                : Colors.red,
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.key),
                            hintText: "Retype the password",
                            labelText: "Confirm Password",
                            suffix: Icon(widget.matchPassword
                                ? Icons.check_circle
                                : Icons.warning_rounded),
                          ),
                          onTapOutside: (event) {
                            setState(() {
                              widget.passwordHidden = true;
                            });
                          },
                          onChanged: (value) {
                            confirmPassword = value;
                            setState(() {
                              widget.matchPassword =
                                  confirmPassword == password;
                              widget.enabled =
                                  widget.matchPassword && widget.validUser;
                            });
                          },
                          obscureText: widget.passwordHidden,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                            onPressed: !widget.enabled
                                ? null
                                : () async {
                                    widget.inProgress = true;
                                    await storage.createUser(
                                        user, name, password, widget.img);
                                    Navigator.pushReplacementNamed(
                                        context, '/login');
                                  },
                            child: const Text("Register"),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Already registered,"),
                            TextButton(
                              onPressed: () => Navigator.pushReplacementNamed(
                                  context, '/login'),
                              child: Text("Login now!"),
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
