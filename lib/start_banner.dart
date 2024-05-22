import 'package:event_master/dashboard.dart';
import 'package:event_master/login.dart';
import 'package:event_master/preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StartBanner extends StatefulWidget {
  const StartBanner({super.key});

  @override
  State<StartBanner> createState() => _StartBannerState();
}

class _StartBannerState extends State<StartBanner> {
  @override
  void initState() {
    super.initState();
    initializeApp(context);
  }

  Future<void> initializeApp(BuildContext context) async {
    Preferences preferences = Preferences();
    bool sessionExists = await preferences.checkSession();
    if (sessionExists) {
      if (kDebugMode) {
        print("Exists");
      }
      String? id = await preferences.loadUserID();
      String? name = await preferences.loadUserName();

      if (context.mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Dashboard(
                      userID: id,
                      userName: name,
                    )));
      }
    } else {
      if (kDebugMode) {
        print("Not exists");
      }
      if (context.mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginWidget()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "EventMaster",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Theme.of(context).textTheme.displayLarge?.fontSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
