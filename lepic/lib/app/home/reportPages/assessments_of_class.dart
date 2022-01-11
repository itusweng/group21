import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exp/app/home/assessmentPages/create_assessment_page.dart';
import 'package:exp/app/home/assessmentPages/record_audio_page.dart';
import 'package:exp/app/home/assessmentPages/start_assess.dart';
import 'package:exp/app/home/model/class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'comparative_report.dart';


class ClassAssessmentsPage extends StatefulWidget {

  const ClassAssessmentsPage({ Key? key,required this.classes }) : super(key: key);
  final Classes classes;

  static Future<void> show(BuildContext context, Classes classes) async {

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ClassAssessmentsPage(classes: classes,),
        fullscreenDialog: true,
      ),
    );
  }
  @override
  _ClassAssessmentsPageState createState() => _ClassAssessmentsPageState();
}

class _ClassAssessmentsPageState extends State<ClassAssessmentsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assessments of Class',
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

  Widget _buildContents(BuildContext context) {
    String classId = widget.classes.Id;
    final reference = FirebaseFirestore.instance.collection('assessments').where('classId',isEqualTo:classId);
    return StreamBuilder<QuerySnapshot>(
      stream: reference.get().asStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['assessmentName']),
              subtitle: Text(data['className']),
              isThreeLine: true,
              onTap: () => ComparativeReportPage.show(context, widget.classes, data['assessId'].toString()),
              //onTap: () => print(data['assessId'].toString()),


            );
          }).toList(),
        );
      },
    );
  }


}
