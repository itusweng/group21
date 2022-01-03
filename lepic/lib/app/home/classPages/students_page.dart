import 'package:exp/app/home/classPages/students_page.dart';
import 'package:flutter/material.dart';

import 'create_student_page.dart';

class StudentPage extends StatefulWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StudentPage(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).canvasColor,
        //title: Text('Profile'),
        title: Text(
          'Students',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => CreateStudentPage.show(context),
          child: Icon(Icons.add)),
    );
  }
}
