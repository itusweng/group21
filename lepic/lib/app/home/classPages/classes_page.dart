import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exp/app/home/classPages/class_list_tile.dart';
import 'package:exp/app/home/model/class.dart';
import 'package:exp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:exp/services/auth.dart';
import 'package:provider/provider.dart';
import 'create_class_page.dart';

class ClassPage extends StatelessWidget {
  const ClassPage({Key? key, required this.auth}) : super(key: key);
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
          'Classes',
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
      floatingActionButton: FloatingActionButton(
          heroTag: 'add',
          onPressed: () => CreateClassPage.show(context),
          child: Icon(Icons.add)),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Classes>>(
      stream: database.classesStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Classes>? myList = snapshot.data;
          final children = myList
              ?.map((classes) => ClassListTile(
            classes: classes,
            onTap: () {},
          ))
              .toList() ??
              [];
          return ListView(children: children);
        }
        if (snapshot.hasError) {
          return Center(child: Text('Some error occurred'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
