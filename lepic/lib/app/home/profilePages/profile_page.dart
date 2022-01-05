import 'package:exp/services/auth.dart';
import 'package:flutter/material.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.auth}) : super(key: key);
  final AuthBase auth;
  Future<void> _signOut(BuildContext context) async {
    try {
      Navigator.pop(context, 'OK');
      await auth.logOut();
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
    return Scaffold(
        appBar: AppBar(
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
            FloatingActionButton(
                onPressed: () => _confirmSignOut(context),
                heroTag: 'logout',
                child: Icon(Icons.logout)),
          ],

        ),
        //body: _buildContent(context),
    );
  }
  /*
  Widget _buildContents(BuildContext context) {

  }

   */
}
