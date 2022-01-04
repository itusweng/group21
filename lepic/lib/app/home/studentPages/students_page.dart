import 'package:exp/app/home/studentPages/students_page.dart';
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
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
