import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class StartAssessPage extends StatefulWidget {

  const StartAssessPage({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StartAssessPage(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _StartAssessPageState createState() =>
      _StartAssessPageState();
}

class _StartAssessPageState extends State<StartAssessPage> {
  String dropdownValue = 'Select Student';
  String _studentId = '' ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Classes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      //body: _buildContents(context),
    );
  }
/*
  Widget _buildContents(BuildContext context) {
    String id =FirebaseAuth.instance.currentUser!.uid;
    final reference = FirebaseFirestore.instance.collection('students');
    return StreamBuilder<QuerySnapshot>(
        stream: reference.get().asStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Center(
            child: const CupertinoActivityIndicator(),
          );
          return new DropdownButton(
                      value: dropdownValue,
                      isDense: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          _studentId = dropdownValue;
                        }
                        );
                      } ,
                      items: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        for(int i = 0; i < data['studentId'].length; i++){
                          return new DropdownMenuItem(
                            value: data['studentId'][i],
                            child: new Text(data['studentId'][i].toString()),
                          );
                        }
                      }).toList(),
                    );
        }
    );
  }

 */
}