

import 'package:exp/app/home/model/student.dart';
import 'package:flutter/material.dart';

class CreateStudentPage extends StatefulWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateStudentPage(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _CreateStudentPageState createState() => _CreateStudentPageState();
}

class _CreateStudentPageState extends State<CreateStudentPage> {
  final _form = GlobalKey<FormState>();
  final TextEditingController _firstname_controller = TextEditingController();
  final TextEditingController _lastname_controller = TextEditingController();
  final TextEditingController _class_controller = TextEditingController();
  String get _studentFirstName => _firstname_controller.text;
  String get _studentLastName => _lastname_controller.text;
  String get _studentClass => _class_controller.text;
  Future<void> _saveStudent() async {
    Navigator.of(context).pop();
    final newStudent = Students(studentFirstName: _studentFirstName,
      studentLastName: _studentLastName,
      studentClass: _studentClass);
    //await widget.database.addStudent(newStudent);
    Navigator.of(context).pop();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('New Student'),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed:() => _saveStudent(),
          ),
        ],
      ),
      body: _buildContents(),
    );
  }
  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Student First Name'),
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Student Last Name'),
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Student Class'),
      ),
    ];
  }
}
