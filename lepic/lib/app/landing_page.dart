import 'package:exp/app/sign_in/sign_in_page.dart';
import 'package:exp/services/auth.dart';
import 'package:exp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/classPages/classes_page.dart';
import 'home/profilePages/user_info_page.dart';

class LandingPage extends StatelessWidget{
  const LandingPage({Key? key, required this.auth}) : super(key: key);
  final AuthBase auth;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return SignInPage(
              auth: auth,
            );
          }
          return Provider<Database>(
            create: (_) => FirestoreDatabase(uid: user.uid),
            child:ClassPage(auth: auth)
              //child:UserInfoPage()
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
