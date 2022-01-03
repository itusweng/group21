import 'package:exp/app/home/classPages/students_page.dart';
import 'package:flutter/material.dart';

import 'create_student_page.dart';

class CreateClassPage extends StatefulWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateClassPage(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<CreateClassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('New Class'),
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
        decoration: InputDecoration(labelText: 'Class Name'),
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Class Level'),
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Creator Name'),
      ),
      TextButton(onPressed: () => StudentPage.show(context),
          child: Text('Students'),)
    ];
  }
}
