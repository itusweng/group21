import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> _addClass(BuildContext context) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.addClass(Classes(classLevel: "Level 1",
          className: 'classA', creatorName: 'aa', studentList: ['damla'])
      );
    } on FirebaseException catch(e){
      final dr = await _showAlertDialog(
        context: context,
        titleText: 'Operation Failed',
        messageText:
        e.message.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).canvasColor,
        //title: Text('Profile'),
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
          FloatingActionButton(onPressed: () => _confirmSignOut(context),
          child: Icon(Icons.logout)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => CreateClassPage.show(context),
          child: Icon(Icons.add)),
    );
  }


  Future<Future> _showAlertDialog({
    required BuildContext context,
    required String titleText,
    required String messageText,
  }) async {
    // set up the buttons
    final Widget okButton = TextButton(
      onPressed: () => Navigator.pop(context, 'OK'),
      child: const Text('OK'),
    );

    // set up the AlertDialog
    final alert = AlertDialog(
      title: Text(titleText),
      content: Text(messageText),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    return showDialog(
      context: context,
      builder: (context) => alert,
    );
  }
}





