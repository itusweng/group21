import 'package:flutter/material.dart';
import 'package:exp/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.auth}) : super(key: key);
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
        title: Text('Home Page'),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.indigo,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Classes',
            backgroundColor: Colors.indigo,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph),
            label: 'Statistics',
            backgroundColor: Colors.indigo,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Assessments',
            backgroundColor: Colors.indigo,
          ),




        ],
      ),
    );
  }
}