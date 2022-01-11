import 'package:exp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    try {
      Navigator.pop(context, 'OK');

      await Auth().logOut();
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> _confirmSignOut(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure that you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => _signOut(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 1,
          actions: <Widget>[
            TextButton(
              onPressed: () => _confirmSignOut(context),
              child: Text('Logout'),
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
            ),
    ]
        ),
        backgroundColor: Colors.white70,
        body: SafeArea(

          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white70,
                    backgroundImage: AssetImage('images/user.png')),

                SizedBox(
                  height: 20,
                  width: 250,
                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                Card(
                    color: Colors.blueGrey,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                    child: ListTile(
                      leading: Icon(Icons.account_circle, color: Colors.black),
                      title: Text(
                        Auth().currentUser!.uid.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                Card(
                  color: Colors.blueGrey,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    title: Text(
                      Auth().currentUser!.email.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}