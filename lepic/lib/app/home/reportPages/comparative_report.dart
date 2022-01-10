import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exp/app/home/assessmentPages/record_audio_page.dart';
import 'package:exp/app/home/model/class.dart';
import 'package:exp/app/home/model/student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComparativeReportPage extends StatefulWidget {

  const ComparativeReportPage({Key? key, required this.classes, required this.assessId }) : super(key: key);
  final Classes classes;
  final String assessId;

  static Future<void> show(BuildContext context,  Classes classes, String assessId) async {

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ComparativeReportPage(classes: classes,assessId: assessId,),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _ComparativeReportPageState createState() =>
      _ComparativeReportPageState();
}

class _ComparativeReportPageState extends State<ComparativeReportPage> {

  List<dynamic> studentList = [];
  List<String> studentNames = ['Ali', 'Ayşe'];
  String className = '';
  String classLevel = '';
  String? stuId;
  String getStudentByIndex(int index) => studentNames[index];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comparative Report',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: _buildContents(context),

    );
  }
  Future<void> getStudentName() async{
    String classId = widget.classes.Id;
    className = widget.classes.className.toString();
    print(className);
    classLevel = widget.classes.classLevel.toString();

    final reference = FirebaseFirestore.instance.doc('classes/$classId');
    await reference.get().then((snapshot) =>
    studentList = snapshot.data()!["studentList"]
    );
    print('AAAAAA');
    print(studentList);
    for(stuId in studentList){
      final ref = FirebaseFirestore.instance.doc('students/$stuId');
      await ref.get().then((snapshot) =>
      studentNames.add(snapshot.data()!["studentFirstName"])
      );
      print(studentNames);

    }
  }
  Widget _buildContents(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: getStudentName(),
      builder: (context,snapshot) {
        return Column(
          children: [
            Container(
                width: screenWidth, // <- important for full screen width
                padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                child:
                buildFirstTable() // returns a datatable
            ),
            SizedBox(height: 10,),
          ],
        );
      },
    );
  }
  Widget buildFirstTable() {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Student',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Level',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Class',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'ZSNW',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: List.generate(studentNames.length, (index) {
        String studentname = getStudentByIndex(index);
        print(studentNames.length);
        return DataRow(
          cells: <DataCell>[
            DataCell(
              Text(studentname),
            ),
            DataCell(
              Text(classLevel),
            ),
            DataCell(
              Text(className),
            ),
            DataCell(
              Text('a'),
            ),
          ],
        );
      }),
    );
  }
}