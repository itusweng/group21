

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exp/app/home/model/class.dart';
import 'package:exp/app/home/model/student.dart';
import 'package:exp/services/api_path.dart';
import 'package:exp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
String classId = '';
class CreateStudentPage extends StatefulWidget {
  //const CreateStudentPage({ Key? key}) : super(key: key);

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

  String dropdownValue = 'Select Class';
  List<String> allClasses = [];
  final _form = GlobalKey<FormState>();
  final TextEditingController _firstname_controller = TextEditingController();
  final TextEditingController _lastname_controller = TextEditingController();
  final TextEditingController _class_controller = TextEditingController();
  String get _studentFirstName => _firstname_controller.text;
  String get _studentLastName => _lastname_controller.text;
  String get _studentClass => _class_controller.text;
  
  Future<void> _saveStudent() async {
    String id =FirebaseAuth.instance.currentUser!.uid;
    final stuId = Uuid().v4();
    final reference = FirebaseFirestore.instance.collection(ApiPath.allClasses(id)).where('className', isEqualTo: _class_controller.text);
    await reference.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //print(doc["classId"]);
        classId = doc["classId"];
      });
    });
    final newStudent = Students(studentId: stuId, classId: classId ,
        studentFirstName: _studentFirstName,
      studentLastName: _studentLastName,
      studentClass: _studentClass);
    await FirestoreDatabase(uid: FirebaseAuth.instance.currentUser!.uid).createStudent(newStudent);
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
        controller: _firstname_controller,
        decoration: InputDecoration(labelText: 'Student First Name'),
      ),
      TextFormField(
        controller: _lastname_controller,
        decoration: InputDecoration(labelText: 'Student Last Name'),
      ),
      TextFormField(
        controller: _class_controller,
        decoration: InputDecoration(labelText: 'Student Class Name'),
      ),

    ];
  }


}
