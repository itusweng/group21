import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exp/app/home/model/class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stats/stats.dart';

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

  List studentList = [];
  List studentNames = [];
  List<int> scores = [];
  String className = '';
  String classLevel = '';
  String? stuId;
  double median = 0.0;
  double sd = 0.0;
  int score = 0;
  List<double> zScore = [];
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
    //print(classId);
    className = widget.classes.className.toString();
    //print(className);
    classLevel = widget.classes.classLevel.toString();
    studentList = widget.classes.studentList;

    //print(studentList);
    for(stuId in studentList){
      final ref = FirebaseFirestore.instance.doc('students/$stuId');
      await ref.get().then((snapshot) =>
      studentNames.add(snapshot.data()!["studentFirstName"])
      );
      //print(studentNames);
    }
    for(stuId in studentList) {
      final reference = FirebaseFirestore.instance.collection('results').where('stuId',isEqualTo: stuId);
      await reference.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          scores.add(doc["numOfCorrectWordsReadPM"]);
          print(scores);

        });

      });
    }


    median = Stats.fromData(scores).median.toDouble();
    sd = Stats.fromData(scores).standardDeviation.toDouble();
    print(median);
    print(sd);
    getZScores();
    print(zScore.length);

  }
  void getZScores()async{
    print('AAAAAAA');
    for(score in scores){
      zScore.add(((score-median)/sd));
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
    if (studentNames.length != zScore.length) {
      final screenWidth = MediaQuery
          .of(context)
          .size
          .width;
      return Container(
        width: screenWidth, // <- important for full screen width
        padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
        child: Text(
            'Not all students have submitted the assessment yet'), // returns a datatable
      );
    }
    else {
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
                Text(zScore[index].toString()),
              ),
            ],
          );
        }),
      );
    }
  }
}