import 'package:event_master/about.dart';
import 'package:event_master/firebase_options.dart';
import 'package:event_master/signup.dart';
import 'package:event_master/start_banner.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dashboard.dart';
import 'login.dart';
import 'register.dart';
import 'ticket.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Master',
      routes: {
        "/home": (context) => Dashboard(),
        "/register": (context) => const RegisterEvent(),
        "/ticket": (context) => const GetTicket(),
        "/login": (context) => LoginWidget(),
        "/signup": (context) => SignupWidget(),
        "/about": (context) => const About(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const StartBanner(),
    );
  }
}
