

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exp/app/home/model/assessment.dart';
import 'package:exp/app/home/model/class.dart';
import 'package:exp/app/home/model/student.dart';
import 'package:exp/services/api_path.dart';
import 'package:exp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
String classId = '';
class CreateAssessmentPage extends StatefulWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateAssessmentPage(),
        fullscreenDialog: true,
      ),
    );
  }
  @override
  _CreateAssessmentPageState createState() => _CreateAssessmentPageState();
}

class _CreateAssessmentPageState extends State<CreateAssessmentPage> {

  final _form = GlobalKey<FormState>();
  final TextEditingController _name_controller = TextEditingController();
  final TextEditingController _text_controller = TextEditingController();
  final TextEditingController _class_controller = TextEditingController();
  String get _assessName => _name_controller.text;
  String get _assessText => _text_controller.text;
  String get _assessClass => _class_controller.text;

  Future<void> _saveAssessment() async {
    String id =FirebaseAuth.instance.currentUser!.uid;
    final assessId = Uuid().v4();
    final reference = FirebaseFirestore.instance.collection(ApiPath.allClasses(id)).where('className', isEqualTo: _class_controller.text);
    await reference.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        classId = doc["classId"];
      });
    });
    final newAssess = Assessment(assessId: assessId, classId: classId ,
        assessmentName: _assessName,
        text: _assessText,
        className: _assessClass);
    await FirestoreDatabase(uid: FirebaseAuth.instance.currentUser!.uid).createAssess(newAssess);
    Navigator.of(context).pop();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('New Assessment'),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed:() => _saveAssessment(),
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
        controller: _name_controller,
        decoration: InputDecoration(labelText: 'Assessment Name'),
      ),
      TextFormField(
        controller: _class_controller,
        decoration: InputDecoration(labelText: 'Assessment Class Name'),
      ),
      TextFormField(
        controller: _text_controller,
        decoration: InputDecoration(labelText: 'Assessment Text'),
        maxLines: null,
      ),

    ];
  }


}
