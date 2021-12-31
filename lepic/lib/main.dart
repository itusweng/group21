import 'package:exp/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/landing_page.dart';
import 'app/sign_in/sign_in_page.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(lepicApp());
}
class lepicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lepic',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: LandingPage(auth: Auth()),
    );
  }
}
